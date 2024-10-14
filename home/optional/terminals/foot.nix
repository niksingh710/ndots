{ lib, config, ... }:
let
  fontName =
    if config.hmod.sops.enable then
      "MonoLisaScript Nerd Font"
    else
      "JetBrainsMono Nerd Font";
in
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce
          "${fontName}:size=12:fontfeatures=calt:fontfeatures=dlig:fontfeatures=liga,termicons:size=10";
        term = "xterm-256color";
        dpi-aware = "no";
      };
      cursor = {
        style = "beam";
        color = "ffffff ${config.lib.stylix.colors.base02}";
        blink = "yes";
      };
    };
  };
}
