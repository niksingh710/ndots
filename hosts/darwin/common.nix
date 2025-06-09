{
  pkgs,
  opts,
  lib,
  config,
  ...
}:
let
  inherit (opts) username;
in
{
  system.stateVersion = 6;
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Necessary for using flakes on this system.
  nix = {
    enable = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        username
        "root"
        "alice"
        "@admin"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      ];
    };
  };

  hm.home = {
    shellAliases.fetch = "${lib.getExe pkgs.fastfetch} -c examples/17.jsonc --kitty-icat $HOME/.logo.png --logo-width 16 --logo-padding-right 3";
    file."logo" = {
      source = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Apple_logo_grey.svg/1010px-Apple_logo_grey.svg.png";
        sha256 = "sha256-K+9hw2uFiRa81RCyOvqzrsZtebBQBQVwle1fvEVWj1o=";
      };
      target = "${config.hm.home.homeDirectory}/.logo.png";
    };
  };

  system.startup.chime = false;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    controlcenter = {
      Bluetooth = true;
      Display = true;
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
    dock = {
      autohide-time-modifier = 0.1;
      autohide = true;
      magnification = true;
      largesize = 80;
      mineffect = "genie";
      persistent-apps = [
        # For custom apps use home-manager location
        # "${config.hm.home.homeDirectory}/Applications/Home Manager Apps/kitty.app"
        "${pkgs.google-chrome}/Applications/Google Chrome.app"
        "${pkgs.kitty}/Applications/Kitty.app"
        "/System/Applications/Photos.app"
        "/System/Applications/FaceTime.app"
        "/System/Applications/Messages.app"
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
}
