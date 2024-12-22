{ self, pkgs, opts, ... }:
let stateVersion = "23.11";
in {
  hm = {
    home.shellAliases.cdh = "cd /run/media/${opts.username}/hdd";
    hmod = {
      # TODO: put control for all type virtualisation (will make vm setup easy)
      sops.enable = true;
      rclone.enable = true;
      virtualisation.waydroid = true;
      firefox = {
        plugins = true;
        shyfox = true;
      };
    };
  };

  # core.sops = false;
  nmod = {
    ssh.enable = false;
    hardware.ddc = true;
    intel.governor = "ondemand";
    intel.throttled = true;
    virtualisation.waydroid = true;
    network = {
      timezone = "Asia/Kolkata";
      firewall = true;
      stevenblack = true;
    };
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
      encrypted.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  imports = [
    ./hardware.nix
    ./amdgpu.nix
    ./games.nix

    # custom modules (TODO: Move them into a separate repository) [give a thought if it is a gread idea or not]
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
        "${self}/home/core/stylix"
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
