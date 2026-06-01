#!/usr/bin/env bash
set -e
echo "🎨 Setting up Wayland & Desktop utilities..."

# Core Compositor & UI
sudo pacman -S --needed --noconfirm \
  sway swaybg waybar wofi grim slurp kitty \
  xorg-xwayland ttf-jetbrains-mono-nerd flatpak

# Flatpak Applications
echo "📦 Configuring Flathub repository..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

if ! flatpak list | grep -qi Obsidian; then
  echo "📝 Installing Obsidian..."
  sudo flatpak install -y flathub md.obsidian.Obsidian
else
  echo "✅ Obsidian already installed."
fi

echo "✅ Wayland layer complete!"
