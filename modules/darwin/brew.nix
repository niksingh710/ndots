{
  # packages for darwin those are installed via homebrew
  homebrew = {
    taps = [ ];
    casks = [
      "blip"
      "betterdisplay"
      "element"
      "homerow"
      "imageoptim"
      "karabiner-elements" # check home/darwin/karabiner.nix
      "keepingyouawake"
      "lulu"
      "protonvpn"
      "signal"
      "soundsource"
      "tailscale-app"
      "whatsapp"
      "zulip"
    ];
    brews = [ ];
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
