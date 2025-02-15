{
  wayland.windowManager.hyprland.settings = {
    workspace = [
      "special:comms,gapsin:15,gapsout:50"
      "special:comms,gapsin:15,gapsout:50"
      "special:comms,gapsin:15,gapsout:50"

      "special:quick,gapsin:15,gapsout:50"
      "special:quick,gapsin:15,gapsout:50"
      "special:quick,gapsin:15,gapsout:50"
    ];
    windowrule = [
      "float,^(Choose Files)$"
    ];

    windowrulev2 = [

      "workspace special:quick, class:(org.pulseaudio.pavucontrol)"

      "workspace special:comms, class:(Signal)"
      "workspace special:comms, class:(discord)"
      "workspace special:comms, class:(so.libdb.dissent)"
      "workspace special:comms, class:(org.gnome.Fractal)"
      "workspace special:comms, class:(Zulip)"
      "workspace special:comms, class:(telegram-desktop)"
      "workspace special:comms, class:(io.github.kukuruzka165.materialgram)"

      "group set, class:(org.pulseaudio.pavucontrol)"
      "group set, class:(discord)"
      "group set, class:(so.libdb.dissent)"
      "group set, class:(org.telegram.desktop)"
      "group set, class:(io.github.kukuruzka165.materialgram)"
      "group set, class:(org.gnome.Fractal)"
      "group set, class:(Zulip)"
      "group set, class:(geary)"

      "noanim,class:^(rofi)$"

      "float,title:Choose*"
      "float,title:(ripdrag)"
      "pin,title:(ripdrag)"

      "float,class:(java)"

      "float,class:(mpv)"
      "float,class:(xdg-desktop-portal-gtk)"
      "float,title:(MainPicker)"

      "pin,class:(showmethekey-gtk)"
      "float,class:(showmethekey-gtk)"
      "noborder,class:(showmethekey-gtk)"
      "noinitialfocus,class:(showmethekey-gtk)"
      "noblur,class:(showmethekey-gtk)"
      "noshadow,class:(showmethekey-gtk)"
      "opacity 8,class:(showmethekey-gtk)"
      "maxsize 310 95,class:(showmethekey-gtk)"

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
      "ignorezero, notifications"
      "blur, firefox"
      "blur, discord"
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
