{ device ? "/dev/vda"
, encrypted ? false
, impermanence ? false
, ssd ? true
, ssdOptions ? [ ]
, lib ? import <nixpkgs/lib>
, ...
}: with lib;
let
  mountOptions = [ "compress=zstd" ] ++ optionals ssd ssdOptions;
  subvolumes = mkMerge [
    {
      "/root" = {
        mountpoint = "/";
        inherit mountOptions;
      };
      "/nix" = {
        mountOptions = mountOptions ++ [ "noatime" "noacl" ];
        mountpoint = "/nix"; # Nix subvolume
      };
    }
    (mkIf impermanence {
      "/persistent" = {
        inherit mountOptions;
        mountpoint = "/persistent"; # Persistent subvolume
      };
    })
  ];

in
{
  disko.devices.disk.primary = {
    type = "disk";
    device = device;
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
              mountOptions = [ "defaults" "umask=0077" ];
            };
          };
        }
        (mkIf (!encrypted) {
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

        (mkIf encrypted {
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
