# 👑 Dotfiles & System Bootstrap

> **One command. One repo. A fully working system.**

This repository exists to **reproduce my complete Linux environment** — terminal, editor, shell, desktop behavior, and tooling — on any fresh Ubuntu machine with **minimum friction and maximum clarity**.

Everything here is intentional.
Nothing is implicit.

---

## 🚀 One-Command Installation

The goal of this repository is simple:

> **Clone the repo and set up the entire system with a single command.**

```bash
curl -fsSL https://raw.githubusercontent.com/<your-username>/dotfiles/main/installer.sh | bash
```

What this command will do:

1. Install and configure **nala**
2. Install all required **system packages**
3. Set up **Flatpak + Flathub**
4. Install required **CLI tools, runtimes, and utilities**
5. Install **Docker (official packages)**
6. Install **GNOME extension tooling**
7. Clone this repository
8. Apply all **dotfiles using GNU Stow**

➡️ After this finishes, the system is ready to use.

---

## 🧠 Why This Repository Exists

Modern Linux setups fail for three reasons:

1. Config files without documented dependencies
2. Manual installs that are forgotten over time
3. "Works on my machine" assumptions

This repository solves that by:

* Treating **the system as code**
* Separating **configuration** from **installation**
* Making every dependency **explicit and reproducible**
* Favoring **clarity over cleverness**

The result is a setup that can be:

* Rebuilt from scratch
* Audited
* Extended
* Trusted

---

## 🧩 What This Repository Manages

### ✔ Managed

* Shell, terminal, editor, git, tmux configs
* CLI tooling and developer utilities
* Desktop workflow (GNOME extensions + behavior)
* Language runtimes required by tooling

### ✖ Not Managed

* Kernel / bootloader
* Hardware drivers
* Ubuntu base packages
* User data

---

## 📦 System Dependencies

> This section is **authoritative**. The installer installs exactly what is listed here.

---

### 🖥️ Package Management

* `nala`
* `apt-transport-https`
* `ca-certificates`
* `software-properties-common`
* `gnupg`

---

### 🧑‍💻 Core CLI Utilities

#### File Navigation & Search

* `yazi` *(installed via cargo)*
* `zoxide`
* `bat`
* `eza`
* `fzf`
* `fd-find`
* `ripgrep`

#### Core Unix Tools

* `curl`
* `wget`
* `jq`
* `tree`
* `zip`
* `unzip`
* `grep`

---

### 🧑‍💻 Development Tooling

#### Version Control

* `git`
* `lazygit`

#### Compilers & Toolchains

* `build-essential`
* `cargo` (Rust toolchain)
* `rust-analyzer`
* `clangd`

#### Node.js (via NVM)

* `nodejs` *(installed via nvm)*
* Global npm packages:

  * `neovim`

---

### 🖥️ Terminal & Shell

* `kitty`
* `tmux`
* `zsh`
* `starship`
* `zsh-autosuggestions`
* `zsh-syntax-highlighting`
* `wl-clipboard`

---

### ✨ Neovim (LazyVim)

* `neovim` (>= 0.9)

External plugin dependencies:

* `git`
* `ripgrep`
* `fd-find`
* `nodejs`
* `python3`

---

### 🐳 Containers

Installed from official Docker repositories:

* `docker-ce`
* `docker-ce-cli`
* `containerd.io`
* `docker-buildx-plugin`
* `docker-compose-plugin`

---

### 📦 Flatpak & AppImage Support

* `flatpak`
* `gnome-software-plugin-flatpak`
* `libfuse2`

Flatpak apps installed:

* `md.obsidian.Obsidian`

---

### 🖥️ GNOME Desktop

#### Core Utilities

* `gnome-tweaks`
* `dconf-cli`
* `gnome-shell-extensions`
* `gnome-shell-extension-manager`

#### GNOME Extensions (User-Installed)

* Forge
* Simple Workspaces Bar
* Disable Workspace Switcher
* Blur My Shell
* Clipboard Indicator
* Caffeine
* Bing Wallpaper
* Net Speed Simplified
* Lock Keys

---

## 📁 Repository Structure

```text
dotfiles/
├── nvim/
├── tmux/
├── zsh/
├── git/
├── kitty/
├── installer.sh
└── README.md
```

All configuration is applied using **GNU Stow**.

---

## 🔁 Rebuilding the System

On a fresh Ubuntu install:

```bash
curl -fsSL https://raw.githubusercontent.com/<your-username>/dotfiles/main/installer.sh | bash
```

No manual steps required.

---

## 🧭 Philosophy

* Explicit over implicit
* Reproducible over convenient
* Simple over clever
* Auditable over magical

👑 *A system you understand is a system you control.*

