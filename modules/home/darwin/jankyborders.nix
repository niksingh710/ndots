{ lib, ... }:
with lib;
{
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 1.0;
      hidpi = true;
      blacklist = "Kandji,FaceTime,Screen Sharing";
      active_color = mkDefault "0xffffffff"; # so that stylix can override
      inactive_color = mkDefault "0x00000000"; # so that stylix can override
    };
  };
}
