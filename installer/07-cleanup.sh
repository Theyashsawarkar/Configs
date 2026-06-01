#!/usr/bin/env bash
set -e
echo "🧹 Starting system cleanup..."

echo "📦 Removing unneeded dependencies..."
# Suppress error if no orphans exist
sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true

echo "🧼 Cleaning package cache..."
sudo pacman -Sc --noconfirm

if command -v flatpak &>/dev/null; then
  echo "🧹 Cleaning unused Flatpak runtimes..."
  flatpak uninstall --unused -y || true
fi

echo ""
echo "🎉 ============================================= 🎉"
echo "✅ Arch System setup completed successfully!"
echo "👑 Your Wayland environment is now fully reproducible."
echo "🎉 ============================================= 🎉"
echo ""

read -rp "🔁 Reboot now to apply all changes? (y/N): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
  echo "🚀 Rebooting..."
  sudo reboot
else
  echo "🕊️ Reboot skipped. You may reboot later for full effect."
fi
