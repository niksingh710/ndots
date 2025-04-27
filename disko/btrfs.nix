{
  disko.devices.disk.primary = {
    device = "/dev/vda";
    type = "disk";
    content = {
      type = "gpt"; # GPT partitioning scheme
      partitions = {
        # EFI Partition
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "defaults"
              "umask=0077"
            ];
          };
        };
        # Btrfs Root Partition
        root = {
          size = "100%"; # Use remaining space
          type = "8300"; # Linux filesystem type
          content = {
            type = "btrfs";
            subvolumes = {
              "/root" = {
                mountOptions = [ "compress=zstd" ]; # Compression for better performance
                mountpoint = "/"; # Root subvolume
              };
              "/persistent" = {
                mountOptions = [ "compress=zstd" ]; # Compression for persistent data
                mountpoint = "/persistent"; # Persistent subvolume
              };
              "/nix" = {
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                  "noacl"
                ]; # Optimize for Nix store
                mountpoint = "/nix"; # Nix subvolume
              };
            };
          };
        };
      };
    };
  };
}
