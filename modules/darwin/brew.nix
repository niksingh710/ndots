{
  # packages for darwin those are installed via homebrew
  homebrew = {
    taps = [ ];
    casks = [
      "betterdisplay"
      "blip"
      "cleanupbuddy"
      "element"
      "homerow"
      "imageoptim"
      "karabiner-elements" # check home/darwin/karabiner.nix
      "keepingyouawake"
      "keycastr"
      "lulu"
      "maccy"
      "numi"
      "protonvpn"
      "signal"
      "tailscale-app"
      "utm"
      "whatsapp"
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
