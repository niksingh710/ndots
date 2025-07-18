{ flake, lib, config, ... }:
let
  inherit (flake) self;
in
{
  imports = [
    self.nixosModules.disko

    # btrfs.partition.nix is a fn that returns partition scheme
    (import "${self}/modules/nixos/disko/btrfs.partition.nix" {
      inherit (config.ndots.disko) encrypted impermanence ssd;
      inherit lib;
    })

    ./impermanence
  ];

  # These options come from `nixosModules.disko`
  ndots.disko = {
    ssd.enable = true;
    encrypted.enable = true;
    impermanence = true;
  };

  services.fstrim.enable = config.ndots.disko.ssd.enable;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
  boot = {
    initrd.availableKernelModules = lib.optionals
      config.ndots.disko.ssd.enable [ "nvme" ];
    supportedFilesystems = [
      "btrfs"
      "vfat"
    ];
  };
}
