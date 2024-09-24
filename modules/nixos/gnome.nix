{ lib, config, pkgs, ... }:
with lib;
let cfg = config.nmod.gnome;
in {
  options.nmod.gnome = {
    # This bare option will install and setup essentials for window managers and core gnome
    full = mkEnableOption "full";

    online = mkEnableOption "online";
  };

  config = mkMerge [
    {
      services.gnome.gnome-keyring.enable = true;
      environment.systemPackages = with pkgs; [ gnome-sound-recorder ];
    }

    (mkIf cfg.online {
      services.gnome.gnome-online-accounts.enable = true;
      environment.systemPackages = with pkgs; [
        endeavour
        gnome-online-accounts
        gnome-online-accounts-gtk
        gnome-control-center

        thunderbird
      ];
    })

    (mkIf cfg.full {
      # Place for full gnome config
    })
  ];
}
