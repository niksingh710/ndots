{ pkgs, ... }:
{

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  homebrew = {
    casks = [
      "homerow"
      "caffeine"
      "zulip"
      "signal"
      "zen"
      "pronotes"
      "tailscale"
    ];
    brews = [ "brew-cask-completion" ];
    masApps = {
      # only mac apps supported not iOS one
      # "tailscale" = 1475387142;
    };
  };


  homebrew = {
    enable = true;
    taps = [
      "homebrew/cask"
    ];
    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };
  };
}
