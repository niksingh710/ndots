{
  pkgs,
  self,
  ...
}:
{
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  environment.defaultPackages = with pkgs; [
    utm
    sshfs
    macfuse-stubs
  ];
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "mas"
      "brew-cask-completion"
    ];
    casks = [
      "zulip"
    ];
    masApps = {
      "tailscale" = 1475387142;
    };
  };

  hm.home.packages = with pkgs; [
    (callPackage "${self}/pkgs/zen-browser-darwin/default.nix" { })
    (callPackage "${self}/pkgs/the-boring-notch/default.nix" { })
    (callPackage "${self}/pkgs/pronotes/default.nix" { })
    (callPackage "${self}/pkgs/signal-darwin/default.nix" { })
    google-chrome
    wget
    android-tools
    raycast
    whatsapp-for-mac
    keycastr
  ];
}
