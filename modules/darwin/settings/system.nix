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
      spaces.spans-displays = true; # aerospace https://nikitabobko.github.io/AeroSpace/guide#a-note-on-displays-have-separate-spaces
      trackpad.Clicking = true;
      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        QuitMenuItem = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowPathbar = true;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
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
        NSAutomaticWindowAnimationsEnabled = false;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.000;
      };
      WindowManager.EnableStandardClickToShowDesktop = false;
      screencapture = {
        show-thumbnail = true;
        target = "clipboard";
      };
      dock = {
        autohide-time-modifier = 0.1;
        static-only = true;
        autohide = true;
        magnification = true;
        largesize = 80;
        mineffect = "genie";
        show-recents = false;
        show-process-indicators = true;
        scroll-to-open = true;
        wvous-br-corner = 1;
        wvous-bl-corner = 1;
        wvous-tr-corner = 1;
        wvous-tl-corner = 1;
        slow-motion-allowed = true;
        expose-group-apps = true; # aerospace https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control
        persistent-apps = [
          # For custom apps use home-manager location
          # "${config.hm.home.homeDirectory}/Applications/Home Manager Trampolines/kitty.app"
          # "${pkgs.google-chrome}/Applications/Google Chrome.app"
          # "${pkgs.kitty}/Applications/Kitty.app"
          # "/System/Applications/Photos.app"
          # "/System/Applications/FaceTime.app"
          # "/System/Applications/Messages.app"
          # "/System/Applications/Mail.app"
          # "/System/Applications/Calendar.app"
          # "/System/Applications/System Settings.app"
          # "/Applications/Slack.app"
        ];
      };
    };
  };
}
