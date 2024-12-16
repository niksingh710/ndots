{ config, ... }: {
  wayland.windowManager.hyprland.settings = {

    env = [

      "GTK_THEME,adw-gtk3"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,${config.stylix.cursor.name}"

      # XDG
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # QT
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

      # Toolkit
      "SDL_VIDEODRIVER,wayland"
      "_JAVA_AWT_WM_NONEREPARENTING,1"
      "_JAVA_OPTIONS,-Dawt.useSystemAAFontSettings=on"
      "JAVA_FONTS,/usr/share/fonts/TTF"
      "CLUTTER_BACKEND,wayland"
      "GDK_BACKEND,wayland,x11"

      # Enabling firefox wayland
      "BROWSER,firefox"
      "MOZ_ENABLE_WAYLAND,1"

      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      "SWWW_TRANSITION_STEP,60"
      "SWWW_TRANSITION,simple"

    ];
  };
}
