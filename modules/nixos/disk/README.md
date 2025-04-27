# Impermanent Setup (Erase Everything After Reboot)

## Overview

### Methods to Achieve an Impermanent Setup
Using an impermanent setup keeps the file structure clean and clutter-free by removing unnecessary files and data after each reboot. This approach ensures a fresh system state while preserving essential configurations and data.

The concept of an impermanent setup revolves around defining specific directories and files to retain while erasing everything else upon reboot. This ensures a fresh system state while preserving important configurations and data.

### Why Use an Impermanent Setup?
There are several methods to achieve this, including:

- **tmpfs**: A temporary filesystem that exists in RAM and clears itself on reboot.
  - *Why not use tmpfs?* Since RAM is limited, downloading large files can lead to "storage full" errors.

- **Manual Cleanup**: Here, you handle filesystem wiping at reboot.
  - *What does the impermanence module do?* It does not wipe the filesystem but performs bind mounts from persistent storage.

>[!NOTE]
>
> `fileSystems."/persistent".neededForBoot = true;` make sure this flag is set up where "/persistent" could be the partition you use to keep the data.
>        as this will make sure this partition is available at boot time.

## Implementation Strategy

The approach consists of two steps:
1. **Wipe the system at boot**
2. **Keep essential data in persistent storage**

### System Cleanup Script

A script is used to clean the disk at boot while keeping a backup of the previous boot:

```sh
# This script cleans the disk at boot to maintain a fresh setup
# It also retains a backup of the previous boot state

mkdir -p /btrfs_tmp
mount ${mount} /btrfs_tmp

if [[ -e /btrfs_tmp/root ]]; then
  mkdir -p /btrfs_tmp/old_roots
  timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%b-%d-%Y_%H:%M:%S")
  mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
fi

# Function to recursively delete Btrfs subvolumes
delete_subvolume_recursively() {
  IFS=$'\n'
  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
      delete_subvolume_recursively "/btrfs_tmp/$i"
  done
  btrfs subvolume delete "$1"
}

# Delete backups older than 30 days
find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30 -exec bash -c 'delete_subvolume_recursively "$0"' {} \;

btrfs subvolume create /btrfs_tmp/root
umount /btrfs_tmp
```

### How It Works

1. Creates `/btrfs_tmp` and mounts the partition containing the system root.
2. Moves the current root to `old_roots` with a timestamp.
3. Deletes old backups older than 30 days.
4. Allows rollback access if needed.

To access previous boot states:
```sh
sudo mount /dev/path/to/root /mnt
ls /mnt/old_roots
```

### Automating Cleanup at Boot

For unencrypted systems:
```nix
postDeviceCommands = cleanup;
```

For encrypted systems, `postDeviceCommands` does not work, so a systemd service (invokes after device is decrypted) is required:

```nix
systemd = mkIf cfg.encrypted {
  enable = true;
  services.wipe-my-fs = {
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@<nameofencrypteddrive>.service" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = cleanup;
  };
};
```

Replace `<nameofencrypteddrive>` with the actual drive name. Check partition creation methods and impermanence module usage for reference.

## Setting Up Persistence

To retain necessary files and directories across reboots, add the impermanence module to your NixOS configuration:

```nix
environment.persistence."/persistent" = {
  enable = true;
  hideMounts = true;
  directories = [
    "/etc/nixos"
    "/etc/secureboot"
    "/var/log"
    "/var/lib/nixos"
    "/var/lib/systemd/coredump"
    "/etc/NetworkManager/system-connections"
    "/usr/systemd-placeholder" # Required for systemd
  ];
  users.${opts.username} = {
    directories = [
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }
      { directory = ".nixops"; mode = "0700"; }
      { directory = ".local/share/keyrings"; mode = "0700"; }
    ];
  };
};
```

This ensures essential system configurations and user data persist across reboots while keeping everything else temporary.
