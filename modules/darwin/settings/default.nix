{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports =
    with builtins;
    with lib;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  system.startup.chime = false;
  system.keyboard = {
    enableKeyMapping = true;
  };
  system.defaults = {
    controlcenter = {
      Bluetooth = true;
      Display = false;
      Sound = true;
      NowPlaying = true;
      BatteryShowPercentage = false;
      FocusModes = false;
      AirDrop = false;
    };
    ActivityMonitor = {
      IconType = 0;
      ShowCategory = 100;
      SortColumn = "CPUUsage";
      SortDirection = 0;
    };
    screencapture = {
      show-thumbnail = true;
      target = "clipboard";
    };
    trackpad.Clicking = true;
    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
    };
    dock = {
      autohide-time-modifier = 0.1;
      autohide = true;
      magnification = true;
      largesize = 80;
      mineffect = "genie";
      show-recents = false;
      show-process-indicators = true;
      scroll-to-open = true;
      wvous-br-corner = 14;
      wvous-bl-corner = 7;
      slow-motion-allowed = true;
      persistent-others = [
        "${config.hm.home.homeDirectory}/Downloads"
      ];
      persistent-apps = [
        # For custom apps use home-manager location
        # "${config.hm.home.homeDirectory}/Applications/Home Manager Trampolines/kitty.app"
        "${pkgs.google-chrome}/Applications/Google Chrome.app"
        "${pkgs.kitty}/Applications/Kitty.app"
        "${config.hm.home.homeDirectory}/Applications/Home Manager Trampolines/Zen.app"
        "/System/Applications/Photos.app"
        "/System/Applications/FaceTime.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/System Settings.app"
        "/Applications/Kandji Self Service.app"
        "/Applications/Slack.app"
      ];
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      KeyRepeat = 1;
      InitialKeyRepeat = 20;
      ApplePressAndHoldEnabled = true;
      NSWindowShouldDragOnGesture = true;
    };
  };

  # Configs that I use
  # CapsLock Enhancement: https://ke-complex-modifications.pqrs.org/#caps_lock_enhancement
  services.karabiner-elements = {
    enable = true;
    package = pkgs.karabiner-elements.overrideAttrs (old: {
      version = "14.13.0";

      src = pkgs.fetchurl {
        inherit (old.src) url;
        hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
      };

      dontFixup = true;
    });
  };

}
