#!/usr/bin/env bash
set -e
echo "🧬 Applying dotfiles using GNU Stow..."

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

STOW_PACKAGES=(
  zsh
  nvim
  tmux
  kitty
  sway
  waybar
  wofi
  bin
)

echo "🔗 Creating symlinks..."
for pkg in "${STOW_PACKAGES[@]}"; do
  if [ -d "$pkg" ]; then
    stow --verbose --target="$HOME" "$pkg"
  else
    echo "⚠️ Skipping $pkg (directory not found in repo)"
  fi
done

echo "🔐 Ensuring local bin scripts are executable..."
chmod +x "$HOME/.local/bin/"* 2>/dev/null || true

echo "✅ Dotfiles applied successfully!"
