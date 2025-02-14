# 🚀 Custom ISO Builds

### Flake Output: Minimal and Customizable ISO

Currently, the flake outputs a single ISO: **`x86ISO`** (aliased as `iso`), a minimal yet functional `x86_64` ISO designed for simplicity and ease of setup.

### 🔨 Building the ISO

To build the ISO, use the following command:

```bash
nix build .#x86ISO.config.system.build.isoImage
# or
nix build .#iso
```

Once built, you'll find the ISO at:
**`result/iso/<name-date-tag>.iso`**

---

### ✨ Minimal ISO Features

The **Minimal ISO** is based on the default NixOS minimal ISO with some subtle but impactful enhancements:
- **NetworkManager** enabled by default, replacing the wireless module for easier network access.
- A custom, bare-minimum Neovim setup, including Nix LSP support.
- Preinstalled tools like **Git** and **Disko** for quick setups.
- home-manger zsh settedup with some basic plugins/vim edits.

---

### 🛠️ Planned Enhancements for Minimal Config

Here are some features planned for future updates:
- [ ] **Quick Chroot Access Scripts**: Simplify and streamline chroot operations.
- [ ] **Quick Installation Scripts**: Speed up the installation process with pre-configured scripts.

---
