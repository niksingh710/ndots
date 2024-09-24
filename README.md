<p align="center" style="color:grey">

![image](https://github.com/user-attachments/assets/1f1600e9-a1d9-4aa6-9035-5d19e4ece908)

<div align="center">

<small><small>**[gdots](https://github.com/niksingh710/gdots) + [cdots](https://github.com/niksingh710/cdots)**</small>
</div>


<div align="center">
<table>
<tbody>
<td align="center">
<img width="2000" height="0"><br>

My **[NixOS](https://nixos.org)/[Nix Config](https://nixos.org/download/#download-nix)** built using flakes.<br>
I've used **[Flake-Parts](https://flake.parts)** to modularize the config.<br>
<small>**Hyprland + Waybar Setup**</small><br>

![GitHub repo size](https://img.shields.io/github/repo-size/niksingh710/ndots)
![GitHub Org's stars](https://img.shields.io/github/stars/niksingh710%2Fndots)
![GitHub forks](https://img.shields.io/github/forks/niksingh710/ndots)
![GitHub last commit](https://img.shields.io/github/last-commit/niksingh710/ndots)

<img width="2000" height="0">
</td>
</tbody>
</table>
</div>
</p>

This repository contains my Linux rice setup, along with my shell configuration, which I find intuitive and efficient to work with. 🎨✨

### NixOS

#### Partitioning 🖥️

> Boot and Btrfs modules are in `/modules/nixos/`.

The general disk layout I prefer is embedded within these two sections of my config.

The **disks** module of my flake is structured like this. The `btrfs` module also supports encryption as an option.

```sh
Label: nixos
  subvol:
    root      -> /
    home      -> /home
    nix       -> /nix
    btr_pool  -> /btr_pool

Label: boot
  vfat -> /boot
```

### 🎨 Hyprland and Themed Setup

![image](https://github.com/user-attachments/assets/1cd4da7d-ef2c-45f8-9a14-ada0288e1d6d)


| ![discord](https://github.com/user-attachments/assets/6921057d-1c40-417f-a652-a0063e98a55b) | ![telegram](https://github.com/user-attachments/assets/22afed68-5ce7-4d1e-8866-3ad46f613a85) |
| ----- | ------- |

![image](https://github.com/user-attachments/assets/ee3824ed-5d00-4f77-9661-fe2c3d4fcf32)

![image](https://github.com/user-attachments/assets/151cc1af-7841-497b-8d43-516f78c24048)

You can find more UI previews in my old repository: [gdots](https://github.com/niksingh710/gdots) or in my [Hacky issue](https://github.com/niksingh710/ndots/issues/1)

**Colors are adapted from the wallpapers**

* For Telegram and Vesktop I have ported `walogram` and `midnight` themes respectively for my stylix config.

I’ve used **[Stylix](https://github.com/danth/stylix)** for theming.

Check out my favorite color schemes on [base16](https://github.com/niksingh710/base-16-colors).

---

### 🐚 Shell Setup

> **Note:** My shell module is written as an independent HomeManager module, so it can be utilized by anyone.

#### Starship Config for Zsh with Transience

![image](https://github.com/niksingh710/cdots/assets/60490474/1c1bff31-eb4f-43e7-8dd4-e55892622977)

#### FZF Keybindings

| ![image](https://github.com/niksingh710/cdots/assets/60490474/6a96631d-02c0-4c5a-a777-1edaff594081) | ![image](https://github.com/niksingh710/cdots/assets/60490474/3a761775-695a-4160-a835-6077fd1cc90a) |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| ![image](https://github.com/niksingh710/cdots/assets/60490474/6ab40586-9978-4b8c-b944-f0343e180b6a) | ![image](https://github.com/niksingh710/cdots/assets/60490474/bf5cf7cf-b5bc-4d59-92ed-d73c71f15df8) |

<div align="center">

| Mapping                 | Action                                           |
| ----------------------- | ------------------------------------------------ |
| `Ctrl-j`                | Move down                                        |
| `Ctrl-k`                | Move up                                          |
| `Ctrl-p`                | Toggle preview window                            |
| `Ctrl-r`                | Search through history                           |
| `Ctrl-/`                | Search for an AUR package with installation info |
| `Ctrl-space` (fzf list) | Select multiple                                  |
| `Ctrl-/` (fzf list)     | Deselect multiple                                |

</div>

---

<small>

**Note:** The preview images were taken from my old repositories: [cdots](https://github.com/niksingh710/cdots) / [gdots](https://github.com/niksingh710/gdots).

I will be updating this repository in the near future. If you can help with documentation or have suggestions regarding structure or configuration, feel free to open an issue or create a PR. Any guidance regarding a more "Nix way" of doing things is also welcome.

</small>

> ⚠️ **Warning**: This repository is a **Work in Progress** (WIP).

---

### 📝 TODO

- [ ] Add more previews to the documentation.
- [ ] Setup Impermanence
- [ ] Expand the documentation.
- [ ] Complete all the `TODO:` comments in the code.
- [ ] Add other devices from local configurations.
- [ ] Add development shells.
- [ ] Set up `direnv`.
- [ ] Set up [Diskio](https://github.com/nix-community/disko) for disk partitioning.

---

## Acknowledgments

I would like to extend my heartfelt thanks to the following individuals whose configurations and resources greatly inspired me to Use NixOs:

- [iynaix](https://github.com/iynaix)
- [fufexan](https://github.com/fufexan)
- [nobbZ](https://github.com/nobbZ)
- [lilleaila ](https://github.com/lilleaila)
- [vimjoyer](https://github.com/vimjoyer)
