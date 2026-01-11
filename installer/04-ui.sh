
#!/usr/bin/env bash
set -e

echo "🎨 Setting up UI & desktop tools..."

# --------------------------------------------------
# GNOME core UI tools
# --------------------------------------------------
echo "🧩 Installing GNOME extensions support..."

sudo nala install -y \
  gnome-shell-extensions \
  gnome-shell-extension-manager \
  gnome-tweaks

# --------------------------------------------------
# Flatpak apps
# --------------------------------------------------
echo "📦 Installing Flatpak applications..."

# Obsidian
if ! flatpak list | grep -qi Obsidian; then
  echo "📝 Installing Obsidian..."
  sudo flatpak install -y flathub md.obsidian.Obsidian
else
  echo "✅ Obsidian already installed"
fi

# --------------------------------------------------
# GTK themes & UI extras (safe defaults)
# --------------------------------------------------
echo "🎭 Installing UI extras..."

sudo nala install -y \
  gnome-themes-extra

# --------------------------------------------------
# Final message
# --------------------------------------------------
echo "✅ UI layer complete!"
echo "➡️  Moving to dotfiles setup..."
