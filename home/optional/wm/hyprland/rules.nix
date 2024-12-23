{
  wayland.windowManager.hyprland.settings = {
    workspace = [

      "special:comms,gapsin:15,gapsout:50"
      "special:comms,gapsin:15,gapsout:50"
      "special:comms,gapsin:15,gapsout:50"

      # for smart gaps
      # "w[tv1], gapsout:0, gapsin:0"
      # "f[1], gapsout:0, gapsin:0"
    ];
    windowrule = [

      "workspace 6,^(lutris)"

      "workspace 6,^(Steam)"
      "workspace 6,^(steam)"
      "workspace 6,^(gamescope)$"

      "float,^(Choose Files)$"
      "float,^(steam)$"
      "float,^(Steam)$"

    ];
    windowrulev2 = [

      # for smart gaps
      # "bordersize 0, floating:0, onworkspace:w[tv1]"
      # "rounding 0, floating:0, onworkspace:w[tv1]"
      # "bordersize 0, floating:0, onworkspace:f[1]"
      # "rounding 0, floating:0, onworkspace:f[1]"

      "workspace special:comms, class:(Signal)"
      "workspace special:comms, class:(vesktop)"
      "workspace special:comms, class:(so.libdb.dissent)"
      "workspace special:comms, class:(org.gnome.Fractal)"
      "workspace special:comms, class:(telegram-desktop)"
      "workspace special:comms, class:( io.github.kukuruzka165.materialgram)"
      "group set, class:(vesktop)"
      "group set, class:(so.libdb.dissent)"
      "group set, class:(org.telegram.desktop)"
      "group set, class:(io.github.kukuruzka165.materialgram)"
      "group set, class:(org.gnome.Fractal)"
      "group set, class:(geary)"

      "noanim,class:^(rofi)$"

      "float,title:Choose*"
      "float,title:(ripdrag)"
      "pin,title:(ripdrag)"

      "float,class:(java)"

      "float,class:(mpv)"
      "float,class:(xdg-desktop-portal-gtk)"

      "pin,class:(showmethekey-gtk)"
      "float,class:(showmethekey-gtk)"
      "noborder,class:(showmethekey-gtk)"
      "noinitialfocus,class:(showmethekey-gtk)"
      "noblur,class:(showmethekey-gtk)"
      "noshadow,class:(showmethekey-gtk)"
      "opacity 8,class:(showmethekey-gtk)"
      "maxsize 310 95,class:(showmethekey-gtk)"

      "float,class:^(Waydroid)$"

      "opaque, class:^(foot)$"
      "float, class:^(foot-quick)$"
      "size 100% 40%, class:^(foot-quick)$"
      "move 0% 60%, class:^(foot-quick)$"
      "dimaround, class:^(foot-quick)$"
      "noborder, class:^(foot-quick)$"
      "rounding 0, class:^(foot-quick)$"
      "noshadow, class:^(foot-quick)$"
      "noanim,class:^(foot-quick)$"
      "pin,class:^(foot-quick)$"
      "stayfocused,class:^(foot-quick)$"

      "idleinhibit fullscreen, class:^(firefox)$"
      "idleinhibit fullscreen, class:^(mpv)$"
      "idleinhibit none,class:^(YouTube Music)$"

    ];

    layerrule = [
      "noanim, swww"
      "ignorezero, waybar"
      "ignorezero, notifications"

      "blur, firefox"
      "blur, waybar"
      "blur, rofi"
      "blur, vesktop"
      "blurpopups, firefox"
      "blurpopups, (.*)"

      "blur, swaync-control-center"
      "blur, swaync-notification-window"

      "ignorezero, swaync-control-center"
      "ignorezero, swaync-notification-window"

      "blur, notifications"
    ];
  };
}
