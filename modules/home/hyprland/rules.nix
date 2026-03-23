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
      "float on,match:class ^(Choose Files)$"
      "float on,match:class ^(Choose Directory)$"

      "opacity 1,match:class zen-beta"
      "opacity 1,match:class kitty"
      "opacity 1,match:initial_title Picture-in-Picture"

      "match:workspace special:quick, match:class (org.pulseaudio.pavucontrol)"

      "match:workspace special:comms, match:class (Signal)"
      "match:workspace special:comms, match:class (discord)"
      "match:workspace special:comms, match:class (so.libdb.dissent)"
      "match:workspace special:comms, match:class (org.gnome.Fractal)"
      "match:workspace special:comms, match:class (Zulip)"
      "match:workspace special:comms, match:class (telegram-desktop)"
      "match:workspace special:comms, match:class (org.telegram.desktop)"
      "match:workspace special:comms, match:class (io.github.kukuruzka165.materialgram)"
      "match:workspace special:comms, match:class (Mailspring)"
      "match:workspace 10, match:initial_title (Discord Popout)"

      "match:group set, match:class (org.pulseaudio.pavucontrol)"
      "match:group set, match:class (discord)"
      "match:group set, match:class (so.libdb.dissent)"
      "match:group set, match:class (org.telegram.desktop)"
      "match:group set, match:class (telegram-desktop)"
      "match:group set, match:class (io.github.kukuruzka165.materialgram)"
      "match:group set, match:class (org.gnome.Fractal)"
      "match:group set, match:class (Zulip)"
      "match:group set, match:class (geary)"
      "match:group set, match:class (Mailspring)"
      "match:group unset, match:initial_title (Discord Popout)"

      "no_anim on,match:class ^(rofi)$"

      "float on,match:initial_title (Picture-in-Picture)"
      "float on,match:title Choose*"
      "float on,match:title (ripdrag)"
      "match:pin on,match:title (ripdrag)"

      "float on,match:class (.telegram-desktop-wrapped)"
      "float on,match:title (Choose Files)"

      "float on,match:class (java)"

      "float on,match:class (mpv)"
      "float on,match:class (xdg-desktop-portal-gtk)"
      "float on,match:title (MainPicker)"

      "match:pin on,match:class (showmethekey-gtk)"
      "float on,match:class (showmethekey-gtk)"
      "border_size 0,match:class (showmethekey-gtk)"
      "no_initial_focus on,match:class (showmethekey-gtk)"
      "no_blur on,match:class (showmethekey-gtk)"
      "no_shadow on,match:class (showmethekey-gtk)"
      "opacity 1,match:class (showmethekey-gtk)"
      "max_size 310 95,match:class (showmethekey-gtk)"

      "float on, match:class ^(quick-term)$"
      "size 100% 40%, match:class ^(quick-term)$"
      "move 0% 60%, match:class ^(quick-term)$"
      "dim_around on, match:class ^(quick-term)$"
      "border_size 0, match:class ^(quick-term)$"
      "rounding 0, match:class ^(quick-term)$"
      "no_shadow on, match:class ^(quick-term)$"
      "no_anim on,match:class ^(quick-term)$"
      "match:pin on,match:class ^(quick-term)$"
      "stay_focused on,match:class ^(quick-term)$"

      "idle_inhibit fullscreen, match:class ^(firefox)$"
      "idle_inhibit fullscreen, match:class ^(librewolf)$"
      "idle_inhibit fullscreen, match:class ^(mpv)$"
      "idle_inhibit none,match:class ^(YouTube Music)$"

      "size 35% 40%,match:class clipse"
      "center 1,match:class clipse"
    ];

    layerrule = [
      "ignore_alpha 0, match:namespace notifications"
      "ignore_alpha 0, match:namespace firefox"
      "ignore_alpha 0, match:namespace zen-beta"
      "blur on, match:namespace firefox"
      "blur on, match:namespace librewolf"
      "blur on, match:namespace discord"
      "blur on, match:namespace zen-beta"
      "blur_popups on, match:namespace zen-beta"
      "blur_popups on, match:namespace firefox"
      "blur_popups on, match:namespace librewolf"
      "blur_popups on, match:namespace (.*)"

      "blur on, match:namespace swaync-control-center"
      "blur on, match:namespace swaync-notification-window"

      "ignore_alpha 0, match:namespace swaync-control-center"
      "ignore_alpha 0, match:namespace swaync-notification-window"

      "blur on, match:namespace notifications"
    ];
  };
}
