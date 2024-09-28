{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      (google-chrome.override {
        commandLineArgs =
          [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
      })
    ];
}
