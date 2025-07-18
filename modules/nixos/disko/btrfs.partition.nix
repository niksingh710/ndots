{ device ? "/dev/vda"
, encrypted ? { enable = false; name = "cryptroot"; }
, impermanence ? false
, ssd ? { enable = false; options = [ ]; }
, lib ? import <nixpkgs/lib>
, ...
}:
with lib;
let
  mountOptions = [ "compress=zstd" ] ++ optionals ssd.enable ssd.options;
  subvolumes = mkMerge [
    {
      "/root" = {
        mountpoint = "/";
        inherit mountOptions;
      };
      "/nix" = {
        mountOptions = mountOptions ++ [
          "noatime"
          "noacl"
        ];
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
              mountOptions = [
                "defaults"
                "umask=0077"
              ];
            };
          };
        }
        {
          # /dev/disk/by-partlabel/disk-primary-root
          root = {
            size = "100%"; # Use remaining space
            type = "8300"; # Linux filesystem type
            content =
              if encrypted.enable then
                {
                  type = "luks";
                  name = encrypted.name;
                  settings.allowDiscards = true;
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    inherit subvolumes;
                  };
                }
              else {
                type = "btrfs";
                inherit subvolumes;
              };
          };
        }
      ];
    };
  };
}
