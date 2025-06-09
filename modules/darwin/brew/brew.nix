{
  pkgs,
  self,
  ...
}:
{
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
      "whatsapp" = 310633997;
    };
  };

  hm.home.packages = [
    (pkgs.callPackage "${self}/pkgs/zen-browser-darwin/default.nix" { })
    (pkgs.callPackage "${self}/pkgs/the-boring-notch/default.nix" { })
  ];
}
