{ pkgs, ... }:
{

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  homebrew = {
    casks = [ "zulip" "signal" "zen" "pronotes" "tailscale" ];
    brews = [ "mas" "brew-cask-completion" ];
    masApps = {
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
