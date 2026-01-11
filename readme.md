# ⚙️ Configs — My Linux Setup, Automated

Welcome to **Configs** 👋✨
This repository contains my **personal Linux configuration** and a **fully automated installer** to recreate my system on any fresh machine.

> 🧠 Think of this repo as *"infrastructure as dotfiles"* — opinionated, reproducible, and evolving.

⚠️ **Status:** This project is **actively under development**.
Things may change, improve, or break — and that’s intentional 🚧

Contributions, suggestions, and ideas are **very welcome** 🤝💙

---

## 🚀 One‑Command Installation

Clone the repository (always from the **main** branch) and run the installer:

```bash
git clone -b main https://github.com/Theyashsawarkar/Configs.git ~/dotfiles \
  && cd ~/dotfiles \
  && chmod +x installer/install.sh \
  && ./installer/install.sh
```

That’s it ✨☕
The installer will take care of almost everything automatically.

---

## 🧩 What this setup gives you

✔ A fully configured **developer‑friendly Linux system**
✔ Clean, fast **terminal & shell experience**
✔ Modern CLI tools replacing legacy Unix defaults
✔ Structured, maintainable dotfiles using GNU Stow
✔ Modular installer scripts (easy to extend later)

---

## 🛠️ Installer overview

The installer is split into **small, ordered scripts**:

```text
installer/
├── 00-preflight.sh   → sanity checks & sudo
├── 01-system.sh      → core system packages
├── 02-dev.sh         → dev tools (node, rust, yazi, etc.)
├── 03-shell.sh       → zsh, oh-my-zsh, powerlevel10k
├── 04-ui.sh          → fonts, kitty, UI tools
├── 05-dotfiles.sh    → GNU stow & symlinks
├── 06-cleanup.sh     → cleanup + reboot prompt
├── install.sh        → master runner
├── guide.md          → 📘 detailed documentation
```

📌 Scripts run **automatically in numeric order** (`00 → 99`).

---

## 📦 Packages & tools installed

Below is a **high‑level overview** of what gets installed and *why* 👇

### 🖥️ Core system & utilities

| Package           | Why it exists                           |
| ----------------- | --------------------------------------- |
| `nala`            | Faster, cleaner frontend for apt 📦     |
| `curl`, `wget`    | Network & download utilities 🌐         |
| `build-essential` | Required for compiling native tools 🛠️ |
| `ca-certificates` | Secure HTTPS communication 🔐           |
| `stow`            | Dotfile symlink management 🔗           |
| `ripgrep`         | Lightning‑fast text search 🔍           |
| `fd-find`         | Better, simpler `find` 🔎               |
| `eza`             | Modern replacement for `ls` 📁          |
| `bat`             | Syntax‑highlighted `cat` 📄             |
| `fzf`             | Fuzzy finder everywhere ⚡               |
| `btop`            | Modern system monitor 📊                |
| `httpie`          | Human-friendly HTTP client for APIs 🌐⚡ |

---

### 👨‍💻 Developer tools

(Yes, `httpie` is non-negotiable 😄)

| Tool               | Purpose                                   |
| ------------------ | ----------------------------------------- |
| `git`              | Version control 🧠                        |
| `neovim`           | Primary editor (LazyVim based) ✍️         |
| `tmux`             | Terminal multiplexing 🪟                  |
| `lazygit`          | TUI Git client 🌱                         |
| `nodejs` + `npm`   | JavaScript ecosystem ⚙️                   |
| `cargo` / `rustup` | Rust tooling 🦀                           |
| `docker` + plugins | Containers & dev environments 🐳          |
| `yazi`             | Terminal file manager (binary install) 📂 |

---

### 🐚 Shell & terminal

| Tool           | Why                                  |
| -------------- | ------------------------------------ |
| `zsh`          | Default shell 🐚                     |
| Oh My Zsh      | Plugin & config framework ✨          |
| Powerlevel10k  | Fast, minimal, informative prompt 🚀 |
| `zoxide`       | Smarter `cd` 🧭                      |
| `wl-clipboard` | Clipboard support (Wayland) 📋       |
| `kitty`        | GPU‑accelerated terminal emulator ⚡  |

---

### 🎨 UI, fonts & desktop

| Tool                      | Purpose                          |
| ------------------------- | -------------------------------- |
| Nerd Fonts                | Icons & glyphs for terminal 💠   |
| ComicShannsMono Nerd Font | My preferred terminal font 😄    |
| GNOME Extensions          | Productivity & visuals 🧩        |
| Flatpak                   | App distribution & sandboxing 📦 |
| Obsidian (Flatpak)        | Notes & knowledge base 🧠        |

---

## 🔗 Dotfiles management

All configuration files live inside this repo and are applied using **GNU Stow**.

```text
~/.zshrc  →  ~/dotfiles/zsh/.zshrc
```

🧠 Editing files in `$HOME` edits the **real files in this repo**.

---

## 🔄 Reboot & post‑install

At the end of the setup:

* You’ll be asked whether to **reboot** 🔄
* Reboot is **recommended** (Docker groups, shell changes)

---

## 🤝 Contributing

This is a **personal project**, but:

* 💡 Suggestions are welcome
* 🐛 Issues & fixes are appreciated
* 🔧 PRs are encouraged

If something looks interesting or useful — feel free to jump in 🚀

---

## 🧭 Final note

This repo is **not static**.

> It evolves as my workflow evolves.

If you’re reading this — you’re looking at a **living system** 🌱

Happy hacking! 😄✨

