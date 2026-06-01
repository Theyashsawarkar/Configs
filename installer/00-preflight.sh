#!/usr/bin/env bash
set -e
echo "🧪 Preflight checks starting..."

# 1. Strict OS Detection
if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" != "arch" ]; then
    echo "❌ OS Mismatch: This installer exclusively supports Arch Linux."
    echo "Detected OS: $NAME"
    exit 1
  fi
else
  echo "❌ Cannot determine OS. /etc/os-release is missing."
  exit 1
fi
echo "✅ Arch Linux detected."

# 2. Cache sudo credentials
echo "🔐 Requesting sudo access..."
sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &

# 3. Synchronize package databases
echo "📦 Syncing package databases and updating system core..."
sudo pacman -Syu --noconfirm

echo "✅ Preflight complete!"
