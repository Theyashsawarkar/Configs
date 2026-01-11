
#!/usr/bin/env bash
set -e

echo "🐚 Setting up Zsh, prompt, and fonts..."

# --------------------------------------------------
# Install Zsh
# --------------------------------------------------
if ! command -v zsh >/dev/null 2>&1; then
  echo "📦 Installing Zsh..."
  sudo nala install -y zsh
else
  echo "✅ Zsh already installed"
fi

# --------------------------------------------------
# Install Oh My Zsh (non-interactive)
# --------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "✨ Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed"
fi

# --------------------------------------------------
# Install Powerlevel10k theme
# --------------------------------------------------
P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
  echo "🎨 Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "✅ Powerlevel10k already installed"
fi

# --------------------------------------------------
# Install Nerd Fonts (ComicShannsMono Nerd Font)
# --------------------------------------------------
echo "🔤 Installing Nerd Fonts (ComicShannsMono)..."

FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="ComicShannsMono Nerd Font"
FONT_ZIP="ComicShannsMono.zip"

mkdir -p "$FONT_DIR"

if ! fc-list | grep -qi "ComicShannsMono"; then
  TMP_DIR="$(mktemp -d)"
  cd "$TMP_DIR"

  curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ComicShannsMono.zip
  unzip -q "$FONT_ZIP" -d "$FONT_DIR"

  fc-cache -fv

  cd ~
  rm -rf "$TMP_DIR"

  echo "✅ Nerd Font installed"
else
  echo "✅ Nerd Font already installed"
fi

# --------------------------------------------------
# Set Zsh as default shell (non-interactive)
# --------------------------------------------------
ZSH_PATH="$(command -v zsh)"

if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "🔁 Setting Zsh as default shell for $USER..."
  sudo usermod --shell "$ZSH_PATH" "$USER"
else
  echo "✅ Zsh already set as default shell"
fi

# --------------------------------------------------
# Final message
# --------------------------------------------------
echo "✅ Shell layer complete!"
echo "➡️  Moving to UI setup..."
