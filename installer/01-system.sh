
#!/usr/bin/env bash
set -e

echo "⚙️  Installing core system packages and tools..."

# --------------------------------------------------
# System-level packages (OS fundamentals)
# --------------------------------------------------
SYSTEM_PACKAGES=(
  build-essential
  ca-certificates
  curl
  httpie
  wget
  gnupg
  lsb-release
  unzip
  p7zip-full
  libfuse2
  wl-clipboard
)

# --------------------------------------------------
# CLI productivity tools (from distro)
# --------------------------------------------------
CLI_TOOLS=(
  bat
  eza
  fzf
  fd-find
  ripgrep
  btop
  zoxide
)

# --------------------------------------------------
# Terminal & session tools
# --------------------------------------------------
TERMINAL_TOOLS=(
  kitty
  tmux
  stow
)

echo "📦 Installing system packages via nala..."
sudo nala install -y \
  "${SYSTEM_PACKAGES[@]}" \
  "${CLI_TOOLS[@]}" \
  "${TERMINAL_TOOLS[@]}"

# --------------------------------------------------
# Fix Ubuntu binary naming mismatches
# --------------------------------------------------
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
  echo "🔗 Linking batcat → bat"
  sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
fi

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  echo "🔗 Linking fdfind → fd"
  sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd
fi

# --------------------------------------------------
# Install Yazi (upstream binary)
# --------------------------------------------------
echo "📦 Installing Yazi from upstream release..."

YAZI_VERSION="latest"
YAZI_TMP="/tmp/yazi"

mkdir -p "$YAZI_TMP"
cd "$YAZI_TMP"

curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest \
  | grep browser_download_url \
  | grep linux-x86_64 \
  | cut -d '"' -f 4 \
  | wget -qi -

tar -xf yazi-linux-x86_64*.tar.gz

sudo mv yazi*/yazi /usr/local/bin/yazi
sudo chmod +x /usr/local/bin/yazi

cd ~
rm -rf "$YAZI_TMP"

echo "✅ Yazi installed successfully"

# --------------------------------------------------
# Final message
# --------------------------------------------------
echo "✅ Core system layer complete!"
echo "➡️  Moving to developer tools..."
