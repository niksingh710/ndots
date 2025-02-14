# 🏠 Home-Manager Specific Configuration

This configuration is designed for **Non-NixOS systems** such as Ubuntu, Arch, and other distributions. It enables you to:
- Import general-purpose tool configurations.
- Define user-level settings and tools that integrate seamlessly with **home-manager**.

---

### 🔨 Building the Home-Manager Configuration

To build the home-manager configuration, run:

```bash
home-manager switch --flake .#<machine>
```

#### Prerequisites:
1. Ensure **Nix** is installed on your system with **flakes** enabled.
2. Install the **home-manager** package.

---

### ⚡ Temporary Setup

If you don’t want to install **home-manager** via your system's package manager, you can initialize it temporarily using **Nix**:

1. Start a temporary shell with home-manager available:
   ```bash
   nix shell nixpkgs#home-manager
   ```
2. Once inside the shell, let **home-manager** install itself as part of your configuration.

This avoids permanent installation while still allowing you to use home-manager effectively.

---

### 🖥️ Virtual Machine Configurations

The `virt` directory contains virtual machine configurations specifically tailored for non-NixOS systems.

---

### 🛠️ Planned Enhancements

- [ ] Add a script or an easy setup process to install Nix with home-manager for non-NixOS systems.
- [ ] Create a **one-command install** for seamless integration.
