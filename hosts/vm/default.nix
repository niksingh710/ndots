{ self, pkgs, ... }:
let stateVersion = "23.11";
in {
  hm = {
    nvix.pkg = pkgs.nvix-bare;
    # hmod = { };
  };

  nmod = {
    ssh.enable = true;
    intel.governor = "ondemand";
    network.timezone = "Asia/Kolkata";

    boot.plymouth = false;
    disks = {
      partition = "/dev/vda";
      ssd.enable = true;
      impermanence = true;
      encrypted.enable = false;
    };
  };

  imports = [
    ./hardware.nix

    # custom modules (TODO: Move them into a separate repository) [give a thought if it is a gread idea or not]
    self.nixosModules.disks
    self.nixosModules.boot
    self.nixosModules.intel
    self.nixosModules.networking

    self.nixosModules.shell

    self.nixosModules.home

    "${self}/nixos/core"

  ];

  hm.imports = [

    self.homeModules.shell
    self.homeModules.editors

    "${self}/home/core/nix.nix"
    "${self}/home/core/sops.nix"
    "${self}/home/core/impermanence.nix"

    {
      disabledModules = [
        # Ignoring stylix home-manager module coz it comes from nixos
        "${self}/home/core/stylix.nix"
      ];
    }
  ];

  boot.kernelParams = [ "video=1920x1080" ];

  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';
  };

  hm.home.stateVersion = stateVersion;
  system.stateVersion = stateVersion;
}
