{ lib, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce
          "JetBrainsMono Nerd Font:size=12:fontfeatures=calt:fontfeatures=dlig:fontfeatures=liga,termicons:size=10";
        term = "xterm-256color";
        dpi-aware = "no";
      };
      cursor = {
        style = "beam";
        color = "ffffff b35d78";
        blink = "yes";
      };
    };
  };
}
