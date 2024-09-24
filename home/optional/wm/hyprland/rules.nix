{
  wayland.windowManager.hyprland.settings = {
    windowrule = [

      "workspace 2,^(firefox)"
      "workspace 3,^(org.telegram.desktop)"
      "workspace 3,^(io.github.kukuruzka165.materialgram)"
      "workspace 3,^(discord)$"
      "workspace 3,^(vesktop)$"
      "workspace 3,^(google-chat-linux)$"
      "workspace 3,^(whatsapp-for-linux)$"
      "workspace 3,^(tangram)$"
      "workspace 3,^(whatsapp)$"

      "workspace 4,^(mailspring)"

      "workspace 6,^(lutris)"

      "workspace 6,^(Steam)"
      "workspace 6,^(steam)"
      "workspace 6,^(gamescope)$"

      "float,^(Choose Files)$"
      "float,^(steam)$"
      "float,^(Steam)$"

    ];
    windowrulev2 = [
      "noanim,class:^(rofi)$"

      "float,title:(WhatsApp)"

      "float,title:Choose*"
      "float,title:(ripdrag)"
      "pin,title:(ripdrag)"

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
      "blur, vesktop"
      "blurpopups, firefox"
      "blurpopups, (.*)"

      "blur, swaync-control-center"
      "blur, swaync-notification-window"

      "ignorezero, swaync-control-center"
      "ignorezero, swaync-notification-window"

      "blur, notifications"
    ];
    blurls = [
      "swaync-control-center"
      "swaync-notification-window"
      "firefox"
      "vesktop"

      # Blurs
      "rofi"
      "waybar"
      "notifications"
      "gtk-layer-shell"
    ];

  };
}
