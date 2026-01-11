#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "🧬 Applying dotfiles using GNU Stow..."

# --------------------------------------------------
# Preconditions
# --------------------------------------------------
if ! command -v stow &>/dev/null; then
  echo "❌ GNU Stow is not installed"
  exit 1
fi

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "❌ Dotfiles directory not found at $DOTFILES_DIR"
  exit 1
fi

cd "$DOTFILES_DIR"

# --------------------------------------------------
# Stow packages (ONLY what you manage)
# --------------------------------------------------
STOW_PACKAGES=(
  zsh
  nvim
  tmux
  kitty
)

echo "🔗 Creating symlinks..."

for pkg in "${STOW_PACKAGES[@]}"; do
  if [ -d "$pkg" ]; then
    echo "📦 Stowing: $pkg"
    stow --verbose --target="$HOME" "$pkg"
  else
    echo "⚠️  Skipping $pkg (directory not found)"
  fi
done

# --------------------------------------------------
# Post-stow sanity
# --------------------------------------------------
echo "🔐 Ensuring local bin is executable"
chmod +x "$HOME/.local/bin/"* 2>/dev/null || true

echo "✅ Dotfiles applied successfully!"
echo "🧠 Any edits to ~/.zshrc now update ~/dotfiles automatically"
