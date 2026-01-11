
#!/usr/bin/env bash
set -e

echo "🧪 Preflight checks starting..."

# --------------------------------------------------
# Ensure we are on Ubuntu
# --------------------------------------------------
if ! grep -qi ubuntu /etc/os-release; then
  echo "❌ This installer is intended for Ubuntu only."
  exit 1
fi

echo "✅ Ubuntu detected"

# --------------------------------------------------
# Cache sudo credentials
# --------------------------------------------------
echo "🔐 Requesting sudo access..."
sudo -v

# Keep sudo alive during execution
while true; do
  sudo -n true
  sleep 60
done 2>/dev/null &

# --------------------------------------------------
# Update package index
# --------------------------------------------------
echo "📦 Updating package lists..."
sudo apt update

# --------------------------------------------------
# Install nala if missing
# --------------------------------------------------
if ! command -v nala >/dev/null 2>&1; then
  echo "📥 Installing nala..."
  sudo apt install -y nala
else
  echo "✅ nala already installed"
fi

# --------------------------------------------------
# Enable Flatpak support
# --------------------------------------------------
if ! command -v flatpak >/dev/null 2>&1; then
  echo "📦 Installing Flatpak..."
  sudo nala install -y flatpak
else
  echo "✅ Flatpak already installed"
fi

echo "📦 Adding Flathub repository..."
sudo flatpak remote-add --if-not-exists flathub \
  https://flathub.org/repo/flathub.flatpakrepo

# --------------------------------------------------
# Final preflight message
# --------------------------------------------------
echo "✅ Preflight complete!"
echo "➡️  Moving to system package installation..."
