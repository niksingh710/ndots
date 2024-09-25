{ self, ... }:
let stateVersion = "23.11";
in {
  hm = {
    wbar.hotspot = true;
    core.sops = true;
    hmod = {

      virtualisation.waydroid = true;
      firefox = {
        plugins = true;
        shyfox = true;
      };
    };
  };

  core.sops = true;
  nmod = {
    hardware.ddc = true;
    intel.governer = "ondemand";
    virtualisation.waydroid = true;
    network.timezone = "Asia/Kolkata";
    fonts = {
      nerd = true;
      emoji = true;
    };
    boot.secure = true;
    boot.plymouth = true;
    disks.ssd.enable = true;
    disks.btrfs = {
      enable = true;
      backup.enable = true;
      encrypted = {
        enable = true;
        uuid = "/dev/disk/by-uuid/61e9d6a8-ce29-4935-95c3-8f5539868456";
      };
    };
  };

  imports = [
    ./hardware.nix

    # custom modules (TODO: Move them into a seperate repository) [give a thought if it is a gread idea or not]
    self.nixosModules.disks
    self.nixosModules.boot
    self.nixosModules.intel
    self.nixosModules.networking

    self.nixosModules.shell
    self.nixosModules.fonts

    self.nixosModules.gnome
    self.nixosModules.virtualisation

    self.nixosModules.home

    "${self}/nixos/core"
    "${self}/nixos/optional"

  ];

  hm.imports = [

    self.homeModules.shell
    self.homeModules.editors
    self.homeModules.virtualisation

    "${self}/home/core"
    "${self}/home/optional"

    {
      disabledModules = [
        # Ignoring stylix home-manager module coz it comes from nixos
        "${self}/home/core/stylix.nix"
      ];
    }
  ];

  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

  hm.home.stateVersion = stateVersion;
  system.stateVersion = stateVersion;
}
