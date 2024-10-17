{ lib, config, pkgs, ... }:
with lib;
let cfg = config.nmod.virtualisation;
in {
  options.nmod.virtualisation.qemu = mkEnableOption "qemu" // {
    default = true;
  };

  config = mkIf cfg.qemu {
    persist.dir = [
      "/var/lib/libvirt"
    ];
    environment.systemPackages = with pkgs; [ virtiofsd ];
    programs.virt-manager.enable = true;
    services = {
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
    };

    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

  };
}
