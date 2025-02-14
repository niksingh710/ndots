# 🌐 Hosts Configurations

This directory defines **host-specific configurations** that import the necessary modules and settings for each device. These files do not directly contain configurations but serve as entry points to pull in and organize the relevant setups for specific hosts.

---

### 📁 Directory Structure

#### 🐧 **NixOS**
The `nixos` directory includes configurations for devices running **NixOS**. These files import system-level modules and settings to define the behavior and environment for NixOS hosts.

#### 🏠 **Home**
The `home` directory contains configurations for **home-manager** or standalone setups. These are used to:
- Import general-purpose tool configurations.
- Define user-level settings and tools that integrate with **home-manager**.

#### 🍎 **Darwin (macOS)**
The `darwin` directory includes configurations for **macOS** systems. These files import modules and settings optimized for managing macOS environments.

---

### ✨ Key Features

- **Import-Based Structure**: Each file focuses on importing relevant modules and configurations tailored to the specific host environment.
- **Flexible and Modular**: Simplifies customization by keeping configurations reusable and organized.
- **Host-Specific Organization**: Ensures clarity and separation for different operating systems and environments.

---

### 🛠️ Future Enhancements

- [ ] Add support for additional host setups like remote servers or WSL.
- [ ] Provide documentation for the structure and purpose of imported modules.
- [ ] Include examples to showcase best practices for managing host configurations.
