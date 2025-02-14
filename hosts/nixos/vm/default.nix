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
    ++ [

      self.nixosModules.boot
      self.nixosModules.disk
      self.nixosModules.users
      self.nixosModules.shell
      self.nixosModules.intel
      self.nixosModules.sops
      self.nixosModules.nix
      self.nixosModules.utils
      self.nixosModules.hardware
      self.nixosModules.networking
      self.nixosModules.home-manager

      ../impermanence.nix # to make common dir permanenet
    ];

  hm.imports = [
    self.homeModules.editor
    self.homeModules.utils
    self.homeModules.sops
    self.homeModules.nixos
  ];

  hm.ndots = {
    # only enable sops after the installation of the system
    sops.enable = false; # to enable sops services and config
  };

  ndots = {
    sec.askPass = false;
    disk.device = "/dev/vda";
    hardware.opentabletdriver = true;
    disk.impermanence = true;
    disk.encrypted = true;
    users.password = "virt";
    networking.firewall = true;
    networking.ssh = true;
  };

  hm.nvix.pkg = inputs.nvix.packages.${pkgs.system}.core.extend {
    colorscheme = mkForce "tokyodark";
  };

}
