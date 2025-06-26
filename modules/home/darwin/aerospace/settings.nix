{ pkgs, lib, ... }:
let
  floaters = list: lib.map
    (appID: {
      check-further-callbacks = false;
      "if".app-name-regex-substring = appID;
      run = [
        "layout floating"
      ];
    })
    list;
  comms = list: lib.map
    (appID: {
      check-further-callbacks = true;
      "if".during-aerospace-startup = true;
      "if".app-name-regex-substring = appID;
      run = [ "layout tiling" "move-node-to-workspace Comms" ];
    })
    list;
  floatingApps = floaters [
    # Apple apps
    "facetime"
    "messages"
    "findmy"
    "finder"
    "home"
    "freefrom"
    "diskutility"
    "addressbook"
    "colorsyncutility"
    "ical"
    "calculator"
    "automator"
    "appstore"
    "activitymonitor"
    "maps"
    "weather"
    "voicememos"
    "notes"
    "email"
    "mail"
    "Screen Sharing"
    "systempreferences"

    "telegram"
    "slack"
    "discord"
    "slack"
    "spotify"
    "whatsapp"
    "zoom.us"
    "signal"
    "kandji"
    "karabiner"
  ];

  commApps = comms [
    "telegram"
    "slack"
    "discord"
    "slack"
    "spotify"
    "whatsapp"
    "zoom.us"
    "signal"
  ];
in
{
  home.packages = with pkgs;
    [ swipeaerospace ]; # Comes from overlay.
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      accordion-padding = 120;
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      on-focus-changed = [ "move-mouse window-lazy-center" ];
      automatically-unhide-macos-hidden-apps = true;
      on-window-detected = floatingApps ++ commApps;
      exec.inherit-env-vars = true;
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };
      workspace-to-monitor-force-assignment = {
        "10" = "secondary";
      };
      after-startup-command = [
        # Handled by service but still here to ensure it runs
        "exec-and-forget borders"
        "exec-and-forget SwipeAeroSpace"
      ];
    };
  };
}
