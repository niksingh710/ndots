{ pkgs, ... }:
{

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  homebrew = {
    casks = [
      "homerow"
      "zulip"
      "signal"
      "zen"
      "pronotes"
      "tailscale"
    ];
    brews = [ "brew-cask-completion" ];
    masApps = {
      # "tailscale" = 1475387142;
      "chess.com" = 329218549;
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
