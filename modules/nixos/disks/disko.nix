{ inputs, config, lib, ... }:
with lib;
let
  cfg = config.nmod.disks;
  ssdOptions =
    optionals config.nmod.disks.ssd.enable config.nmod.disks.ssd.options;

  subvolumes = mkMerge [
    {
      "/root" = {
        mountOptions = [ "compress=zstd" ]
          ++ ssdOptions; # Compression for better performance
        mountpoint = "/"; # Root subvolume
      };
      "/nix" = {
        mountOptions = [ "compress=zstd" "noatime" "noacl" ]
          ++ ssdOptions; # Optimize for Nix store
        mountpoint = "/nix"; # Nix subvolume
      };
    }
    (mkIf cfg.impermanence {
      "/persistent" = {
        mountOptions = [ "compress=zstd" ]
          ++ ssdOptions; # Compression for persistent data
        mountpoint = "/persistent"; # Persistent subvolume
      };

    })
  ];

in {

  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.disk.primary = {
    type = "disk";
    device = cfg.partition;
    content = {
      type = "gpt";
      partitions = mkMerge [
        {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
        }

        (mkIf (!cfg.encrypted) {
          # /dev/disk/by-partlabel/disk-primary-root
          root = {
            size = "100%"; # Use remaining space
            type = "8300"; # Linux filesystem type
            content = {
              type = "btrfs";
              inherit subvolumes;
            };
          };

        })

        (mkIf cfg.encrypted {
          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                inherit subvolumes;
              };
            };
          };
        })

      ];
    };
  };

}
