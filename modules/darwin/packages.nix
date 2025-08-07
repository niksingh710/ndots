{ pkgs, ... }:
{

  fonts.packages = with pkgs;[ nerd-fonts.jetbrains-mono monaspace ];

  homebrew = {
    casks = [
      "homerow"
      "caffeine"
      "zulip"
      "signal"
      "zen"
      "pronotes"
      "tailscale-app"
      "betterdisplay" # If annoys for premium remove it.
      "karabiner-elements" # check home/darwin/karabiner.nix
    ];
    brews = [ "brew-cask-completion" ];
    masApps = {
      # only mac apps supported not iOS one
      "gifski" = 1351639930;
    };
  };

  homebrew = {
    enable = true;
    taps = [ ];
    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };
  };
}
