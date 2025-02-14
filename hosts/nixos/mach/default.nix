{ inputs, pkgs, lib, self, ... }: with lib;
{
  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)))
    ++ (builtins.attrValues self.nixosModules)
    ++ [
      ../impermanence.nix # to make common dir permanenet
    ];

  hm.imports = [
    self.homeModules.editor
    self.homeModules.browsers
    self.homeModules.utils
    self.homeModules.sops
    self.homeModules.nixos
  ];

  hm.ndots = {
    # only enable sops after the installation of the system
    sops.enable = true; # to enable sops services and config
  };

  ndots = {
    sec.askPass = false;
    disk.device = "/dev/nvme0n1";
    hardware.opentabletdriver = true;
    disk.impermanence = true;
    disk.encrypted = true;
    networking.firewall = true;
    networking.stevenblack = true;
    networking.ssh = false;
    boot.secureboot = true;
    networking.timezone = "Asia/Kolkata";
  };

  hm.nvix.pkg = inputs.nvix.packages.${pkgs.system}.full.extend {
    colorschemes.gruvbox = {
      enable = true;
      settings.transparent_mode = true;
    };
    colorscheme = mkForce "gruvbox";
  };

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
