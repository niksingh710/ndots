{ self, ... }:
let stateVersion = "23.11";
in {
  hm = {
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
    intel.throttled = true;
    virtualisation.waydroid = true;
    network.timezone = "Asia/Kolkata";
    fonts = {
      nerd = true;
      emoji = true;
    };
    boot.secure = true;
    boot.plymouth = true;
    disks = {
      partition = "/dev/nvme0n1";
      ssd.enable = true;
      impermanence = true;
      encrypted = true;
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
