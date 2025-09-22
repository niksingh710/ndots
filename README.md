> [!NOTE]
> **Welcome!**
> This repository contains my Linux/Darwin configurations.
>
> - The original *ricing* and setup details are in the **[OG](https://github.com/niksingh710/ndots/tree/OG)** branch.
> - The **[OG](https://github.com/niksingh710/ndots/tree/OG)** branch also includes documentation for **impermanence**, **disko**,
>   and other advanced configurations such as **secure boot**.
> - Over time, as I explored **Nix**, I aimed to simplify and clean up the setup.
> - My current environment is fully **CLI-based**, accessed via **Tailscale**.
> - More setup idea with awesome ui under consideration for future updates.


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
<small>**Yabai/Aerospace on Darwin**</small><br>

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

| Hosts | Description |
| ----- | ----------- |
| **mach**  | My personal laptop (Hyprland, Waybar, and much more. Most of the setup is set up for this.) |
| **vm**    | Virtual Machine for testing (The tinker box. It is minimal and works for anything [CLI ONLY].) |
| **iso**   | Custom ISO for installation (Includes my [editor](https://github.com/niksingh710/nvix), git, disko, NetworkManager, pre-configured setup.) |
| **jp-mbp**  | MacBook Pro M4 |

```bash
# Instructions to build the ISO (output will reside in result/iso)
nix build .#iso
```

# Instructions to Install
```bash
# (This will partition the disk and mount it)
# [For encryption use enc-disko, that will prompt for password during partitioning]
# (use nixos-generate-config to generate the hardware-configuration)

sudo disko --mode destroy,format,mount ./disko/<type>.nix

sudo nixos-install --no-root-passwd --root /mnt --flake github:niksingh710/ndots#<hostname>
```

>[!Note]
> NixOS is my primary OS right now, and it is an impermanent setup.
  To learn more, search for [`erase-your-darlings nix`](https://grahamc.com/blog/erase-your-darlings) on the internet. (I could have added more resources, but it is a rabbit hole.)

#### Check out [Utils](https://github.com/niksingh710/utils)
Repository for my utility scripts and tools.
They run and anyone can tailor them with overrides.

## 📂 Instructions for the Templates

```
nix flake init -t github:niksingh710/ndots#<template>
```

<img width="2000" height="0">
</td>
</tbody>
</table>
</div>
</p>

<details>
  <summary>📀 Instructions for Default ISO</summary>

```bash
# The disko directory contains both a non-encrypted partitioning scheme (disko)
# and an encrypted partitioning scheme (enc-disko).

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko disko.nix

sudo nixos-install --root /mnt --flake github:niksingh710/ndots#<hostname>
```
</details>

```sh
Label: /dev/disk/by-partlabel/disk-primary-root or /dev/mapper/cryptroot (if rooted)
  subvol:
    root       -> /
    nix        -> /nix
    persistent -> /persistent
    old_root   -> (not mounted [contains backup])

Label: /dev/disk/by-partlabel/disk-primary-ESP
  vfat -> /boot
```

**To search through backup mount Label of root**

### 🎨 Hyprland and Themed Setup

|![image](https://github.com/user-attachments/assets/1cd4da7d-ef2c-45f8-9a14-ada0288e1d6d) |![Image](https://github.com/user-attachments/assets/a8403f60-b58f-47ff-be3a-f51ed8e28306) |
|-|-|

| ![discord](https://github.com/user-attachments/assets/6921057d-1c40-417f-a652-a0063e98a55b) | ![telegram](https://github.com/user-attachments/assets/22afed68-5ce7-4d1e-8866-3ad46f613a85) |
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |

![image](https://github.com/user-attachments/assets/ee3824ed-5d00-4f77-9661-fe2c3d4fcf32)

![image](https://github.com/user-attachments/assets/151cc1af-7841-497b-8d43-516f78c24048)

You can find more UI previews in my old repository: [gdots](https://github.com/niksingh710/gdots) or in my [Hacky issue](https://github.com/niksingh710/ndots/issues/1)

**Colors are adapted from the wallpapers**

- For Telegram I have ported `walogram` theme generator for my stylix config.

I’ve used **[Stylix](https://github.com/danth/stylix)** for theming.

Check out my favorite color schemes on [base16](https://github.com/niksingh710/base-16-colors).

---

### 🐚 Shell Setup

> **Note:** My shell module is written as an independent Home Manager module, so it can be utilized by anyone.

#### Starship Config for Zsh

> Git repository
>
![Image](https://github.com/user-attachments/assets/9d5d8491-1b3e-4e78-9d0d-6c8920560c82)

> Non Git repository
![Image](https://github.com/user-attachments/assets/020cc96d-2e20-470c-a0c6-f6971c199108)

> Files with programming languages
![Image](https://github.com/user-attachments/assets/9c75dde8-3b3d-4946-b350-ce219dc4ed2e)

#### FZF

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
| `Ctrl-space` (fzf list) | toggle selection                                  |

</div>

---

<small>

**Note:** The preview images were taken from my old repositories: [cdots](https://github.com/niksingh710/cdots) / [gdots](https://github.com/niksingh710/gdots).

I will be updating this repository in the near future. If you can help with documentation or have suggestions regarding structure or configuration, feel free to open an issue or create a PR. Any guidance regarding a more "Nix way" of doing things is also welcome.

</small>

---

## Acknowledgments

I would like to extend my heartfelt thanks to the following individuals whose configurations and resources greatly inspired me to Use NixOs:

- [iynaix](https://github.com/iynaix)
- [fufexan](https://github.com/fufexan)
- [nobbZ](https://github.com/nobbZ)
- [lilleaila ](https://github.com/lilleaila)
- [vimjoyer](https://github.com/vimjoyer)
- [srid](https://github.com/srid)
