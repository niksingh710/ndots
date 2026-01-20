{ lib, ... }:
with lib;
let
  blacklistList = [
    "Kandji"
    "Privileges"
    "Screen Sharing"
    "Rclone UI"
    "System Settings"
    "Calculator"
    "Karabiner-Elements"
    "Screen Sharing"
    "iPhone Mirroring"
    "ical"
    "weather"
    "passwords"
    "FaceTime"
    "Finder"
    "LuLu"
    "mpv"
    "Mail"
    "AirSync"
    "WhatsApp"
    "Messages"
    "Tailscale"
  ];

  blacklist = ''"${lib.concatStringsSep "," blacklistList}"'';
in
{
  services.jankyborders = {
    enable = true;
    settings = {
      inherit blacklist;
      style = "round";
      width = 1.0;
      hidpi = "on";
      active_color = mkDefault "0xffffffff"; # so that stylix can override
      inactive_color = mkDefault "0x00000000"; # so that stylix can override
    };
  };
}
