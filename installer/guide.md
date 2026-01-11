
# 🛠️ Dotfiles Installer Guide

Welcome! 👋 This guide explains **what this installer does**, **how it works**, and **how to maintain or extend it safely**. If you ever feel confused, unsure, or need to debug something — this is the **first file to read** 📖✨

---

## 🎯 Why this installer exists

This repository is my **personal system blueprint**.

The goal is simple but powerful:

> 🧠 **Recreate my entire Linux setup on any machine with a single command**

That includes:

* System packages
* Developer tools
* Shell (Zsh + Oh My Zsh + Powerlevel10k)
* UI tools & fonts
* Dotfiles (via symlinks)

Everything here is:

* ✅ Reproducible
* ✅ Automated
* ✅ Opinionated (this is a personal setup, not a generic one)

---

## ⚡ One-command installation

From the root of the dotfiles repository:

```bash
./installer/install.sh
```

That’s it 🚀

The installer will:

1. Run all setup scripts in order
2. Install required packages & tools
3. Set Zsh as default shell automatically
4. Apply dotfiles using `stow`
5. Ask for a reboot at the end

---

## 🧩 How the installer is structured

The `installer/` directory is **intentionally modular**.

```text
installer/
├── 00-preflight.sh   # sanity checks, sudo, environment
├── 01-system.sh      # system packages (nala/apt)
├── 02-dev.sh         # dev tools (node, rust, yazi, etc.)
├── 03-shell.sh       # zsh, oh-my-zsh, powerlevel10k
├── 04-ui.sh          # fonts, kitty, UI-related tools
├── 05-dotfiles.sh    # GNU stow & symlinks
├── 06-cleanup.sh     # cleanup + reboot prompt
├── install.sh        # master runner
├── guide.md          # 📘 you are here
```

Each script has **one responsibility** 🧠

This keeps things:

* Easier to debug
* Easier to extend
* Safer to modify

---

## 🔁 Execution order (VERY IMPORTANT)

Scripts are executed automatically based on **filename order**.

### ✅ Rules

* Only files matching this pattern are executed:

  ```text
  NN-*.sh
  ```
* `NN` = two-digit execution order (`00` → `99`)
* Examples:

  * ✅ `00-preflight.sh`
  * ✅ `23-custom.sh`
  * ❌ `guide.md`
  * ❌ `notes.txt`

### 🔍 What `install.sh` actually does

Internally, it:

* Finds all `NN-*.sh` files
* Sorts them numerically
* Executes them **one by one**
* Stops immediately if any script fails ❌

This guarantees:

* Dependencies are respected
* Failures are visible early

---

## 🧪 Editing, testing & debugging

### ▶️ Run everything

```bash
./install.sh
```

### ▶️ Run a single step

```bash
./03-shell.sh
```

Perfect for:

* Debugging
* Re-running only one stage
* Iterative development

---

## 🔗 Dotfiles & symlinks (important concept)

Dotfiles are managed using **GNU Stow**.

### 🧠 How it works

* Real config files live in `~/dotfiles/`
* `stow` creates **symlinks** in `$HOME`

Example:

```text
~/.zshrc  →  ~/dotfiles/zsh/.zshrc
```

### ✨ Key rule

> Editing a symlink edits the real file.

So when you edit:

```bash
vim ~/.zshrc
```

You are **actually editing the file inside `~/dotfiles`** ✅

This is intentional and safe.

---

## 🐚 Shell setup philosophy

* Zsh is installed automatically
* Zsh is set as **default shell** (no prompt)
* Oh My Zsh is installed if missing
* Powerlevel10k is enabled via `.zshrc`

⚠️ Important:

* Themes, plugins, aliases live in dotfiles
* Installer **does not** hardcode shell config

Dotfiles are the source of truth 🧠✨

---

## 🧰 Package management philosophy

### 📦 System packages

* Installed via **nala** (preferred over apt)
* Focus on stable, distro-friendly packages

### 🧪 Newer tools

Some tools are installed via:

* Official binaries (e.g. `yazi`)
* Language managers (cargo, npm, etc.)

This balances:

* Stability
* Fresh versions

---

## 🧼 Cleanup & reboot

At the end of the installer:

* Temporary files are cleaned
* User is asked whether to reboot 🔄

Reboot is **recommended** but **not forced**.

---

## 🧠 Design principles (TL;DR)

* 🧩 Modular over monolithic
* 🔁 Re-runnable scripts
* 🔍 Explicit over magical
* 👤 Personal > generic

This setup is meant to evolve.

Adding or removing scripts is expected — just follow the naming rules 👍

---

## 🏁 Final note

This installer is not just a script —

> 🏗️ It’s a **codified version of how I want my system to feel**.

If something breaks, improve it.
If something feels missing, add it.

This guide is your compass 🧭✨
