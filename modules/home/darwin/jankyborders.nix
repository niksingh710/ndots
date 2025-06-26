{ lib, ... }: with lib;
{
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 2.0;
      hidpi = true;
      blacklist = "Kandji,FaceTime,Screen Sharing";
      active_color = mkDefault "0xffffffff"; # so that stylix can override
      inactive_color = mkDefault "0x00414550"; # so that stylix can override
    };
  };
}
