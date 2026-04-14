{
  # packages for darwin those are installed via homebrew
  homebrew = {
    taps = [
      "xykong/tap"
    ];
    casks = [
      "betterdisplay"
      "blip"
      "cleanupbuddy"
      "element"
      "homerow"
      "hiddenbar"
      "superkey"
      "pronotes"
      "dockdoor"
      "imageoptim"
      "shottr"
      # "karabiner-elements" # check home/darwin/karabiner.nix
      "keycastr"
      "localsend"
      "flux-markdown"
      # "lulu"
      "fliqlo"
      "maccy"
      "numi"
      "protonvpn"
      "steam"
      "signal"
      "utm"
      "whatsapp"
      "windows-app"
      "zulip"
    ];
    brews = [
      "cirruslabs/cli/tart"
    ];
    masApps = {
      # only mac apps supported not iOS one
      "handmirror" = 1502839586;
      "gifski" = 1351639930;
      "gladys" = 1382386877;
      "tailscale" = 1475387142;
      "amphetamine" = 937984704;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };
    global.brewfile = true;
    greedyCasks = true;
  };
}
