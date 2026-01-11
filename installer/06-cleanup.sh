
#!/usr/bin/env bash
set -e

echo "🧹 Starting system cleanup..."

# --------------------------------------------------
# Package cleanup
# --------------------------------------------------
echo "📦 Removing unused packages..."
sudo nala autoremove -y

echo "🧼 Cleaning package cache..."
sudo nala clean

# --------------------------------------------------
# Flatpak cleanup
# --------------------------------------------------
if command -v flatpak &>/dev/null; then
  echo "🧹 Cleaning unused Flatpak runtimes..."
  flatpak uninstall --unused -y || true
fi

# --------------------------------------------------
# Final message
# --------------------------------------------------
echo ""
echo "🎉 ============================================= 🎉"
echo "✅ System setup completed successfully!"
echo ""
echo "🧠 Installed & configured:"
echo "   • System packages (via nala)"
echo "   • Dev tools (node, cargo, docker, etc.)"
echo "   • Zsh + Oh My Zsh + Powerlevel10k"
echo "   • Nerd Fonts"
echo "   • Kitty, Neovim, Tmux"
echo "   • Dotfiles via GNU Stow"
echo ""
echo "👑 Your system is now fully reproducible."
echo "🎉 ============================================= 🎉"
echo ""

# --------------------------------------------------
# Reboot prompt
# --------------------------------------------------
read -rp "🔁 Reboot now to apply all changes? (y/N): " REBOOT_CHOICE

if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
  echo "🚀 Rebooting..."
  sudo reboot
else
  echo "🕊️ Reboot skipped. You may reboot later for full effect."
fi
