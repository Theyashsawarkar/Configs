#!/usr/bin/env bash
set -e
echo "🐚 Setting up Zsh and prompt..."

sudo pacman -S --needed --noconfirm zsh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "✨ Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  echo "🎨 Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

ZSH_PATH="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "🔁 Setting Zsh as default shell..."
  sudo chsh -s "$ZSH_PATH" "$USER"
fi

echo "✅ Shell layer complete!"
