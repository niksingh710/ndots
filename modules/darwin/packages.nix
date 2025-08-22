{ pkgs, ... }:
{

  fonts.packages = with pkgs;[ nerd-fonts.jetbrains-mono monaspace ];

  homebrew = {
    taps = [ ];
    casks = [
      "blip"
      "betterdisplay"
      "homerow"
      "imageoptim"
      "karabiner-elements" # check home/darwin/karabiner.nix
      "keepingyouawake"
      "lulu"
      "monitorcontrol"
      "pronotes"
      "signal"
      "soundsource"
      "stremio"
      "tailscale-app"
      "zen"
      "zulip"
    ];
    brews = [ ];
    masApps = {
      # only mac apps supported not iOS one
      "handmirror" = 1502839586;
      "gifski" = 1351639930;
      "gladys" = 1382386877;
      "lensocr" = 1549961729;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };
    global.brewfile = true;
  };
}
