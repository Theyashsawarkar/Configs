
# ✅ Project TODOs & Aspirations

This checklist captures the **vision**, **goals**, and **future improvements** for this dotfiles + system bootstrap project.
Think of it as the *north star* ⭐ — not everything must be done immediately, but everything here is intentional.

---

## 🚀 Core Goals (High Priority)

* [ ] **Single-command system setup**
  *One command should fully reproduce the system on a fresh Linux machine.*

* [ ] **Single-command system rollback**
  *One command should undo the setup and restore the system to a clean state.*

* [ ] Fully automated installer flow
  *No manual steps except reboot confirmation.*

* [ ] Deterministic ordering of installer scripts
  *Numbered scripts execute safely and predictably.*

---

## 🧠 Installer Improvements

* [ ] Dry-run mode (`--dry-run`)
  *Show what will be installed without making changes.*

* [ ] Verbose / debug mode
  *Helpful for troubleshooting failures.*

* [ ] Per-module enable/disable flags
  *Example: skip UI or Docker setup.*

* [ ] Rollback support per module
  *Each installer script knows how to undo itself.*

---

## 🧪 Testing & Validation

* [ ] Docker-based automated test flow
  *Validate scripts in headless containers.*

* [ ] VM-based UI testing checklist
  *Ensure GNOME, Kitty, fonts, and extensions work as expected.*

* [ ] Smoke-test command after install
  *Verify critical tools exist (nvim, zsh, docker, kitty, etc.).*

* [ ] Snapshot-based testing workflow documented

---

## 🖥️ Desktop & UI

* [ ] GNOME extensions auto-enable (where possible)
* [ ] GNOME settings export/import (dconf)
* [ ] Keyboard shortcuts auto-configuration
* [ ] Font verification step (Nerd Fonts)

---

## 🐚 Shell & Dev Environment

* [ ] Zsh + Oh My Zsh fully reproducible
* [ ] Powerlevel10k config validation
* [ ] Node, Rust, Docker sanity checks
* [ ] Optional language/tool profiles (future)

---

## 📦 Package Management

* [ ] Clear separation of:

  * System packages
  * Dev tools
  * UI tools
  * Optional tools

* [ ] Version awareness for critical tools

* [ ] Flatpak packages grouped & documented

---

## 📚 Documentation

* [ ] Keep README concise but complete
* [ ] Maintain `GUIDE.md` as internal reference
* [ ] Keep `TESTING.md` updated with real workflows
* [ ] Add architecture diagram (optional)

---

## 🌱 Long-Term Aspirations

* [ ] Cross-distro support (Arch / Fedora)
* [ ] Minimal profile vs full profile
* [ ] CI validation on PRs
* [ ] Public contribution guidelines

---

> 🧭 This is a **personal but disciplined system**.
> It values **clarity**, **reproducibility**, and **intentional automation**.
