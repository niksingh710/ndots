{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
{
  options.ndots.virtualisation.waydroid = mkEnableOption "enable";
  config = {
    # for file sharing add
    # <binary path="/run/current-system/sw/bin/virtiofsd"/>
    environment.systemPackages = with pkgs; [ virtiofsd ];
    programs.virt-manager.enable = true;
    services = {
      qemuGuest.enable = true;
      spice-vdagentd.enable = true;
    };

    hm = {
      wayland.windowManager.hyprland.settings = {
        windowrulev2 = [
          "float,class:^(Waydroid)$"
        ];
        windowrule = [
          "workspace 4,class:^(.virt-manager-wrapped)"
        ];
      };
      home.shellAliases = lib.mkIf config.ndots.virtualisation.waydroid {
        waydroid-start = "sudo systemctl start waydroid-container;setsid waydroid show-full-ui &>/dev/null";
        waydroid-status = "sudo systemctl status waydroid-container";
        waydroid-stop = "sudo waydroid container stop;sleep 1;sudo systemctl stop waydroid-container";
      };
      dconf.settings."org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;

      waydroid.enable = config.ndots.virtualisation.waydroid;
    };
  };

}
