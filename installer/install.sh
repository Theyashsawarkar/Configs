#!/usr/bin/env bash
set -e

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
clear

echo "🚀 ==============================================="
echo "👑 Dynamic Dotfiles & Arch System Bootstrap"
echo "🚀 ==============================================="
echo ""

if [[ $EUID -eq 0 ]]; then
  echo "❌ Do NOT run this script as root."
  echo "👉 Run it as your normal user (sudo will be used when needed)."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "❌ sudo is required but not installed."
  exit 1
fi

echo "🔍 Discovering installer stages..."
mapfile -t STAGES < <(find "$INSTALLER_DIR" -maxdepth 1 -type f -name "[0-9][0-9]-*.sh" | sort)

if [[ ${#STAGES[@]} -eq 0 ]]; then
  echo "❌ No installer stages found."
  exit 1
fi

for stage in "${STAGES[@]}"; do
  STAGE_NAME="$(basename "$stage")"
  if [[ ! -x "$stage" ]]; then
    chmod +x "$stage"
  fi
  echo ""
  echo "▶️ Running $STAGE_NAME"
  echo "-----------------------------------------------"
  "$stage"
done

echo ""
echo "🎉 ==============================================="
echo "✅ All installer stages completed successfully!"
echo "🎉 ==============================================="
echo ""
