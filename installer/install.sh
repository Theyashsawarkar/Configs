
#!/usr/bin/env bash
set -e

# --------------------------------------------------
# Dynamic Master Installer – Dotfiles & System Bootstrap
# --------------------------------------------------

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

clear

echo "🚀 ==============================================="
echo "👑  Dynamic Dotfiles & System Bootstrap Installer"
echo "🚀 ==============================================="
echo ""

echo "📂 Installer directory: $INSTALLER_DIR"
echo ""

# --------------------------------------------------
# Safety checks
# --------------------------------------------------
if [[ $EUID -eq 0 ]]; then
  echo "❌ Do NOT run this script as root."
  echo "👉 Run it as your normal user (sudo will be used when needed)."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "❌ sudo is required but not installed"
  exit 1
fi

# --------------------------------------------------
# Discover installer stages dynamically
# --------------------------------------------------

echo "🔍 Discovering installer stages..."

mapfile -t STAGES < <(
  find "$INSTALLER_DIR" -maxdepth 1 -type f -name "[0-9][0-9]-*.sh" \
  | sort
)

if [[ ${#STAGES[@]} -eq 0 ]]; then
  echo "❌ No installer stages found"
  exit 1
fi

echo "📜 Installer stages found:"
for stage in "${STAGES[@]}"; do
  echo "   • $(basename "$stage")"
done

# --------------------------------------------------
# Execute stages
# --------------------------------------------------

for stage in "${STAGES[@]}"; do
  STAGE_NAME="$(basename "$stage")"

  if [[ ! -x "$stage" ]]; then
    echo "⚠️  Making $STAGE_NAME executable"
    chmod +x "$stage"
  fi

  echo ""
  echo "▶️  Running $STAGE_NAME"
  echo "-----------------------------------------------"

  "$stage"
done

# --------------------------------------------------
# Final success message
# --------------------------------------------------

echo ""
echo "🎉 ==============================================="
echo "✅ All installer stages completed successfully!"
echo "👑 Your system is now fully bootstrapped"
echo "🎉 ==============================================="
echo ""
