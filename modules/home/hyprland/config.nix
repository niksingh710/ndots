{
  config,
  lib,
  opts,
  ...
}:
with lib;
let
  inherit (config.lib.stylix) colors;
  border_active = "0xff${colors.base06}";
  border_inactive = "0x00${colors.base06}";
in
{
  # This expects stylix module is enabled already

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      binds = {
        allow_workspace_cycles = false;
        focus_preferred_method = 1;

        workspace_center_on = 1;
      };

      ecosystem.no_update_news = true;

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        use_active_for_splits = true;
      };

      input = {
        kb_layout = "us";

        follow_mouse = 1;
        float_switch_override_focus = 1;
        mouse_refocus = true;
        repeat_rate = 50;
        repeat_delay = 300;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
        };

        sensitivity = 0.6; # -1.0 - 1.0, 0 means no modification.
      };

      group = {
        group_on_movetoworkspace = true;
        "col.border_active" = mkForce border_active;
        "col.border_inactive" = mkForce border_inactive;
        groupbar = {
          gradients = false;
          render_titles = false;
          height = 5;
          "col.active" = mkForce border_active;
          "col.inactive" = mkForce border_inactive;
          text_color = mkForce "0xff${colors.base0F}";
        };
      };
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = mkForce border_active;
        "col.inactive_border" = mkForce border_inactive;
      };

      decoration = {
        rounding = if opts.rounding then 10 else 0;
        active_opacity = config.stylix.opacity.terminal;
        inactive_opacity = config.stylix.opacity.popups;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          popups = true;

        };
        shadow = {
          enabled = false;
          range = 10;
          render_power = 1;
          scale = 6;
          offset = "2 6";
          ignore_window = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "linear, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, popin"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = false;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        disable_autoreload = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        focus_on_activate = true;
        allow_session_lock_restore = true;
        new_window_takes_over_fullscreen = 1;
        enable_swallow = true;
      };
    };
  };
}
