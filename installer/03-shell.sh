#!/usr/bin/env bash
set -e
echo "🧑‍💻 Installing developer tools..."

# Languages and Tooling
sudo pacman -S --needed --noconfirm \
  git neovim zed nodejs npm rustup docker docker-compose lazygit

# Rust Initialization
echo "🦀 Initializing Rust toolchain..."
if ! command -v rustc >/dev/null 2>&1; then
  rustup default stable
fi

# Docker Configuration
echo "🐳 Configuring Docker..."
sudo systemctl enable docker
sudo systemctl start docker
if ! groups "$USER" | grep -q docker; then
  sudo usermod -aG docker "$USER"
fi

# Global NPM Packages
echo "📦 Installing global npm packages..."
sudo npm install -g neovim

echo "✅ Developer tools installed!"
