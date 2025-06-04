{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "mas"
    ];
    casks = [
      "zulip"
    ];
    masApps = {
      "whatsapp" = 310633997;
    };
  };
}
