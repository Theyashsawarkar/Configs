#!/usr/bin/env bash
set -e
echo "⚙️ Installing core system packages and tools..."

sudo pacman -S --needed --noconfirm \
  base-devel curl wget httpie unzip p7zip \
  wl-clipboard bat eza fzf fd ripgrep btop zoxide \
  stow yazi tmux

echo "✅ Core system layer complete!"
