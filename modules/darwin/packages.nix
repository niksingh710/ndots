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
      "tailscale"
      "betterdisplay" # If annoys for premium remove it.
    ];
    brews = [ "brew-cask-completion" ];
    masApps = {
      # only mac apps supported not iOS one
      # "tailscale" = 1475387142;
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
