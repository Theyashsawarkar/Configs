# 🧪 Testing Guide

<!--toc:start-->

- [🧪 Testing Guide](#🧪-testing-guide)
  - [🐳 1. Docker Testing (CLI & Script Validation)](#🐳-1-docker-testing-cli-script-validation)
    - [✅ What you can test](#what-you-can-test)
    - [📦 Docker Image (Ubuntu)](#📦-docker-image-ubuntu)
    - [▶️ Run Container](#️-run-container)
    - [🔧 Inside the container](#🔧-inside-the-container)
    - [🧠 What to observe](#🧠-what-to-observe)
  - [🖥️ 2. GNOME Boxes (Full System Test) ⭐ Recommended](#🖥️-2-gnome-boxes-full-system-test-recommended)
    - [🔧 Install GNOME Boxes (Host Machine)](#🔧-install-gnome-boxes-host-machine)
    - [📀 Create Test VM](#📀-create-test-vm)
    - [🧪 Inside the VM](#🧪-inside-the-vm)
    - [✅ What to verify](#what-to-verify)
    - [📸 Snapshots (Highly Recommended)](#📸-snapshots-highly-recommended)
  - [🧠 Suggested Testing Workflow](#🧠-suggested-testing-workflow)
  - [🚧 Under Development](#🚧-under-development)
  <!--toc:end-->

This document explains **how to safely test this dotfiles + installer setup** before using it on your real machine.
We use **two testing strategies**:

1. 🐳 **Docker** → Fast CLI / installer logic testing
2. 🖥️ **GNOME Boxes (VM)** → Full desktop & UI testing (recommended)

Both are **free**, reproducible, and safe.

---

## 🐳 1. Docker Testing (CLI & Script Validation)

> Best for: verifying installer scripts, package installation order, failures, logs

⚠️ **Limitations**:

- No GUI / GNOME / Wayland
- No extensions, fonts, or shell visuals
- Perfect only for **system + dev tooling**

### ✅ What you can test

- nala setup
- package installation
- zsh / oh-my-zsh install
- docker group setup
- dotfiles symlinking
- script ordering & failures

---

### 📦 Docker Image (Ubuntu)

```bash
docker pull ubuntu:24.04
```

### ▶️ Run Container

```bash
docker run -it --name dotfiles-test ubuntu:24.04 bash
```

### 🔧 Inside the container

```bash
apt update && apt install -y git sudo curl
```

Clone the repo:

```bash
git clone -b main https://github.com/Theyashsawarkar/Configs.git
cd Configs
```

Run installer:

```bash
chmod +x installer/install.sh
./installer/install.sh
```

### 🧠 What to observe

- ❌ Script failures
- 📦 Missing packages
- 🔁 Wrong ordering
- 🧩 Broken symlinks

Docker = **logic correctness**, not visuals.

---

## 🖥️ 2. GNOME Boxes (Full System Test) ⭐ Recommended

> Best for: **real-world validation** of the entire setup

This tests **everything**:

- GNOME
- Wayland
- Kitty
- Nerd Fonts
- Zsh + Powerlevel10k
- Extensions
- Keybindings

---

### 🔧 Install GNOME Boxes (Host Machine)

```bash
sudo nala install gnome-boxes
```

---

### 📀 Create Test VM

1. Download **Ubuntu 24.04 ISO**
2. Open **GNOME Boxes**
3. Create → Virtual Machine
4. Use default settings
5. Finish Ubuntu installation

---

### 🧪 Inside the VM

Open terminal and run:

```bash
sudo apt update
sudo apt install -y git curl
```

Clone repo (always `main`):

```bash
git clone -b main https://github.com/Theyashsawarkar/Configs.git
cd Configs
```

Run installer:

```bash
chmod +x installer/install.sh
./installer/install.sh
```

---

### ✅ What to verify

| Area        | What to check                  |
| ----------- | ------------------------------ |
| 🐚 Shell    | zsh is default, p10k loads     |
| 🎨 Fonts    | Nerd Font works in Kitty       |
| 🧰 Tools    | git, nvim, fzf, yazi, httpie   |
| 🐳 Docker   | `docker ps` works without sudo |
| 🧩 Dotfiles | symlinks point to repo         |
| 🖥️ UI       | Kitty launches, keybinds work  |

---

### 📸 Snapshots (Highly Recommended)

Before running installer:

- Take a **snapshot** in GNOME Boxes
- If anything breaks → restore instantly ⏪

This enables **fearless testing**.

---

## 🧠 Suggested Testing Workflow

```text
Docker  → logic & scripts
VM      → full desktop
Laptop → final deployment
```

---

## 🚧 Under Development

This setup is evolving.

If something breaks:

- Check installer logs
- Refer this file
- Fix → commit → retest

Testing is part of the system ✨

---

Happy hacking 🧙‍♂️🚀
