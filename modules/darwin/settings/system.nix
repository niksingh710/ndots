{ pkgs, ... }:
{
  programs.zsh.enable = true;
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  system = {
    startup.chime = false;
    keyboard.enableKeyMapping = true;
    defaults = {
      trackpad.Clicking = true;
      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        QuitMenuItem = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        _FXShowPosixPathInTitle = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXRemoveOldTrashItems = true;
      };
      controlcenter = {
        Bluetooth = false;
        Display = false;
        Sound = false;
        NowPlaying = false;
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
      NSGlobalDomain = {
        KeyRepeat = 1;
        AppleMetricUnits = 1;
        InitialKeyRepeat = 20;
        AppleInterfaceStyle = "Dark";
        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        ApplePressAndHoldEnabled = true;
        NSWindowShouldDragOnGesture = true;
      };
      WindowManager.EnableStandardClickToShowDesktop = false;
      screencapture = {
        show-thumbnail = true;
        target = "clipboard";
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
        persistent-apps = [
          # For custom apps use home-manager location
          # "${config.hm.home.homeDirectory}/Applications/Home Manager Trampolines/kitty.app"
          "${pkgs.google-chrome}/Applications/Google Chrome.app"
          "${pkgs.kitty}/Applications/Kitty.app"
          "/System/Applications/Photos.app"
          "/System/Applications/FaceTime.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/System Settings.app"
          "/Applications/Slack.app"
        ];
      };
    };
  };
}
