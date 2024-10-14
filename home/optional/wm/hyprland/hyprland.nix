{ lib, config, ... }:
let inherit (config.lib.stylix) colors;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };

    settings = {
      "$mod" = "SUPER";

      binds = {
        allow_workspace_cycles = false;
        focus_preferred_method = 1;

        workspace_center_on = 1;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = false;
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
        groupbar = {

          gradients = false;
          render_titles = false;

          height = 5;

          "col.active" = lib.mkForce "0xff${colors.base06}";
          "col.inactive" = lib.mkForce "0x73${colors.base06}";

          text_color = lib.mkForce "0xff${colors.base0F}";
        };
      };

      general = {
        "col.inactive_border" = lib.mkForce "0x00${colors.base06}";
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        layout = "dwindle";

        resize_on_border = true;

      };

      decoration = {

        rounding = 10;
        active_opacity = 0.9;
        inactive_opacity = 0.8;

        blur = {
          size = 7;
          passes = 3;
          new_optimizations = true;
          xray = false;
          ignore_opacity = true;
          popups = true;
        };

        drop_shadow = true;
        shadow_range = 10;
        shadow_render_power = 1;
        shadow_scale = 6;
        shadow_offset = "2 6";
        shadow_ignore_window = true;
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
        disable_hyprland_logo = true;
        focus_on_activate = true;
        layers_hog_keyboard_focus = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_mouse_windowdragging = true;
        animate_manual_resizes = true;
        allow_session_lock_restore = false;
        # no_direct_scanout = true;
        new_window_takes_over_fullscreen = true;
        enable_swallow = true;
        swallow_regex = "foot|tmux|zellij";
        disable_autoreload = true;
        vfr = true;
      };

      debug = { disable_logs = true; };

    };
  };
}
