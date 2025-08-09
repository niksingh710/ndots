{ pkgs, ... }:
{

  fonts.packages = with pkgs;[ nerd-fonts.jetbrains-mono monaspace ];

  homebrew = {
    taps = [ ];
    casks = [
      "blip"
      "homerow"
      "imageoptim"
      "karabiner-elements" # check home/darwin/karabiner.nix
      "keepingyouawake"
      # "kindavim" # nice but requires premium license
      "lulu"
      "middleclick"
      "monitorcontrol"
      "pronotes"
      "signal"
      "soundsource"
      "tailscale-app"
      "zen"
      "zulip"
    ];
    brews = [
      "imageoptim-cli"
    ];
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
