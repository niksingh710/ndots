# 🚀 Shell Environment Setup

This directory contains a Nix module based on **Home Manager**, designed to configure a streamlined and efficient shell environment. Each tool is carefully selected to provide an optimal user experience while maintaining simplicity and modularity.

## ✨ Features

### 🔍 **fzf**
- 🌄 Includes a preview window for enhanced file and content exploration.
- ⌨️ Configured with Vim-like key bindings for intuitive navigation.

### 🔗 **tmux**
- 🔄 Equipped with Vim-like key mappings for seamless movement and control.
- **ℹ️ Note:** If tmux fails to render Nerd Font icons correctly:
  1. Ensure a Nerd Font is installed on your system.
  2. Verify that your system locale is properly set up.

### 🖊️ **zsh**
- Minimal yet effective plugin setup:
  - `zsh-vi-mode`: Enables efficient navigation and command editing using Vim key bindings.
  - `zsh-autosuggestions`: Provides intelligent command suggestions.
  - `zsh-syntax-highlighting`: Highlights commands for better readability.

### ✨ **starship**
- A minimal and elegant prompt configured for maximum productivity. Here’s an example of the prompt:

  ![Starship Prompt](https://github.com/niksingh710/cdots/assets/60490474/1c1bff31-eb4f-43e7-8dd4-e55892622977)

### 🛠️ **Git & Additional Tools**
- Basic **Git** and **GitHub CLI (gh)** tools are set up for streamlined version control and repository management.
- Additional tools and aliases are available, including:
  - `btop` for an enhanced resource monitor.
  - `nix-index` for quickly locating Nix packages.

## 📚 Why Use This Module?

- **Modular Design**: Import and tweak as needed for flexibility.
- **Independent Functionality**: Each tool is configured to work standalone or as part of a larger system.
- **Enhanced Productivity**: Provides a cohesive and efficient environment for both basic and advanced workflows.

---
This module encapsulates the true power of **Nix**: modularity, simplicity, and functionality. 🌟 Happy hacking!
