
#!/usr/bin/env bash
set -e

echo "🧑‍💻 Installing developer tools..."

# --------------------------------------------------
# Git (latest via official PPA)
# --------------------------------------------------
echo "🔧 Installing latest Git..."

sudo add-apt-repository -y ppa:git-core/ppa
sudo nala update
sudo nala install -y git

git --version

# --------------------------------------------------
# Neovim (official prebuilt binary)
# --------------------------------------------------
echo "🚀 Installing latest Neovim..."

NVIM_DIR="/opt/nvim"
NVIM_BIN="/usr/local/bin/nvim"

if ! command -v nvim >/dev/null 2>&1; then
  sudo rm -rf "$NVIM_DIR"
  sudo mkdir -p "$NVIM_DIR"

  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo tar -C "$NVIM_DIR" --strip-components=1 -xzf nvim-linux-x86_64.tar.gz
  sudo ln -sf "$NVIM_DIR/bin/nvim" "$NVIM_BIN"

  rm nvim-linux-x86_64.tar.gz
else
  echo "✅ Neovim already installed"
fi

nvim --version | head -n 1

# --------------------------------------------------
# Node.js (NodeSource - latest)
# --------------------------------------------------
echo "🟢 Installing latest Node.js..."

if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
  sudo nala install -y nodejs
else
  echo "✅ Node.js already installed"
fi

node --version
npm --version

# --------------------------------------------------
# npm global packages
# --------------------------------------------------
echo "📦 Installing global npm packages..."
npm install -g neovim

# --------------------------------------------------
# Rust + Cargo (rustup)
# --------------------------------------------------
echo "🦀 Installing Rust toolchain..."

if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "✅ Rust already installed"
fi

export PATH="$HOME/.cargo/bin:$PATH"

rustc --version
cargo --version

# --------------------------------------------------
# Docker (engine + plugins)
# --------------------------------------------------
echo "🐳 Installing Docker..."

if ! command -v docker >/dev/null 2>&1; then
  sudo nala install -y docker.io docker-compose-plugin
else
  echo "✅ Docker already installed"
fi

sudo systemctl enable docker
sudo systemctl start docker

# Add current user to docker group
if ! groups "$USER" | grep -q docker; then
  echo "👤 Adding $USER to docker group..."
  sudo usermod -aG docker "$USER"
else
  echo "✅ User already in docker group"
fi

# --------------------------------------------------
# Lazygit
# --------------------------------------------------
echo "🔥 Installing Lazygit..."
sudo nala install -y lazygit

# --------------------------------------------------
# Final message
# --------------------------------------------------
echo "✅ Developer tools installed!"
echo "➡️  Moving to shell setup..."
