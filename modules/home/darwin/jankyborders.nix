{ lib, ... }:
with lib;
let
  blacklistList = [
    "FaceTime"
    "Kandji"
    "Privileges"
    "Screen Sharing"
    "Rclone UI"
    "iPhone Mirroring"
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
