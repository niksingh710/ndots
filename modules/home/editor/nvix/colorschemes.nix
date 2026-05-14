{ lib, ... }:
{
  catppuccin = {
    enable = lib.mkForce false;
    settings.color_overrides.all = {
      base = "#000000";
      mantle = "#000000";
      crust = "#000000";
    };
  };

}
