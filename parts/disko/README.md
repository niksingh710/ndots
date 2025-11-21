# Disko Setup

This directory contains example configurations for a **disko** partition scheme.

The file **`./partition.nix`** exposes a function that accepts arguments such as the device name and other parameters.
This makes partitioning **flexible**, allowing you to generate schemas dynamically for different machines.

The available schemas are exported in the flake output, so they can be fetched and applied on any remote machine.

---

## 📦 Fetching the Partition Schema

You can retrieve the partition schema for a specific device (for example `/dev/nvme0n1`) using:

```sh
# Fetch partition schema for /dev/nvme0n1
nix eval github:niksingh710/ndots#disko.partition \
  --apply 'b: builtins.fromJSON (builtins.toJSON (b { device = "/dev/nvme0n1"; ssdOptions = []; }))' \
  --impure > <name>.nix
```

This will generate a complete partition configuration and save it to `<name>.nix`.

---

## 🛠 Applying the Partition Schema

Once you have the generated file, apply it (as root):

```sh
sudo disko --mode destroy,format,mount ./<name>.nix
```

This will **destroy**, **format**, and **mount** partitions exactly as defined in your schema.
