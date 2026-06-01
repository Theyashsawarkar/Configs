#!/usr/bin/env bash
set -e
echo "⚙️ Enabling user-level systemd services..."

systemctl --user daemon-reload

# Enable and start the wallpaper timer
if systemctl --user list-unit-files | grep -q "wallpaper.timer"; then
  systemctl --user enable wallpaper.timer --now
  echo "✅ Wallpaper rotation service activated."
else
  echo "⚠️ wallpaper.timer not found. Make sure the unit files are stowed."
fi

echo "✅ Services layer complete!"
