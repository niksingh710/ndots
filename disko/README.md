# 🌐 Disko Setup Guide

Disko is a tool for defining and applying disk partitioning and filesystem setups using Nix. This guide explains how to use Disko for partitioning with predefined configurations.

---

## 📁 Available Partition Configurations

The `disko/` directory contains predefined partitioning configurations:

- **`btrfs.nix`**: Sets up a **Btrfs** filesystem with:
  - `/root`
  - `/boot` (ESP)

- **`btrfs-enc.nix`**: Sets up an **encrypted Btrfs** filesystem, prompting for a password during formatting.

---

## 📦 Generating a Partition Configuration

Use the following command to generate a partition configuration in Nix format:

```sh
nix eval .#disko.btrfs --apply 'b: builtins.fromJSON (builtins.toJSON (b { device = "/dev/nvme0n1"; ssdOptions = []; }))' --impure > partition.nix
```

### Explanation:
- Generates a Nix expression for the specified partitioning setup.
- The `device` argument allows defining the target disk.
- The `--impure` flag allows access to system state.
- Replace `btrfs` with `btrfs-enc` for an encrypted setup.

---

## 🔧 Applying Disko Configurations

### 1️⃣ Fetch the Disko Configuration

Retrieve a configuration with:

```sh
nix eval "github:niksingh710/ndots#disko.<type>" > disko.nix
```

Replace `<type>` with `btrfs` or `btrfs-enc`.

Alternatively, clone the repository:

```sh
git clone https://github.com/niksingh710/ndots.git
```

## 🚀 Using Disko in Nix-Shell

To use Disko without global installation:

```sh
nix-shell -p disko
```

---

### 2️⃣ Update the Target Device

Edit `disko.nix` to specify your disk. Replace `/dev/vda` with your actual target (e.g., `/dev/sda`, `/dev/nvme0n1`).

### 3️⃣ Apply the Partitioning Configuration

Run the following to apply the partitioning:

```sh
sudo disko --mode destroy,format,mount ./disko/<type>.nix
```

Replace `<type>` with `btrfs` or `btrfs-enc`.

### 4️⃣ Fetch the Disko Configuration from flake output.

```sh
nix eval .#disko.btrfs --apply 'b: builtins.fromJSON (builtins.toJSON (b { device = "/dev/nvme0n1"; ssdOptions = []; }))' --impure
```

---

## 🛠️ Integrating Disko with NixOS ISO

Disko can be integrated into a custom **NixOS ISO** build for automated disk partitioning during installation.

## 📚 For `nix-chroot`

Disko allows only mount for the partition structure.

```sh
sudo disko --mode mount ./disko/<type>.nix
```

---

### ✅ Summary
- **Partitioning types**: `btrfs.nix` (Btrfs) and `btrfs-enc.nix` (Encrypted Btrfs).
- **Generate partitions** using `nix eval`.
- **Modify `device` values** before applying.
- **Apply Disko** with `disko --mode disko ./disko/<type>.nix`.

🚀 Happy partitioning with Disko!
