{ pkgs, config, ... }: {
  persist.dir = [ ".config/swaync" ];
  stylix.targets.swaync.enable = false;
  services.swaync = {
    enable = true;
    style =
      let
        inherit (config.lib.stylix) colors;
        # css
      in
      ''
        @define-color background #${colors.base00};
        @define-color foreground #${colors.base0F};
        @define-color cursor #${colors.base00};

        @define-color color0 #${colors.base00};
        @define-color color1 #${colors.base01};
        @define-color color2 #${colors.base02};
        @define-color color3 #${colors.base03};
        @define-color color4 #${colors.base04};
        @define-color color5 #${colors.base05};
        @define-color color6 #${colors.base06};
        @define-color color7 #${colors.base07};
        @define-color color8 #${colors.base08};
        @define-color color9 #${colors.base09};
        @define-color color10 #${colors.base0A};
        @define-color color11 #${colors.base0B};
        @define-color color12 #${colors.base0C};
        @define-color color13 #${colors.base0D};
        @define-color color14 #${colors.base0E};
        @define-color color15 #${colors.base0F};
        @define-color active #${colors.base0F};
        @define-color inactive #${colors.base03};

        .control-center {
          background: alpha(@color1, 0.25);
          margin: 5px 10px 0 0;
          border: 2px solid @foreground;
          border-radius: 15px;
          color: @foreground;
        }

        .widget-title {
          padding: 10px 10px 0px 10px;
          font-size: 22px;
          color: @foreground;
        }

        .widget-title>button {
          border: 2px solid @foreground;
          background: transparent;
          font-size: inherit;
          padding: 0 35px 0 30px;
        }

        .widget-title>button:hover {
          background: @color1;
        }

        .widget-title>button:active {
          background: @color2;
        }

        .widget-dnd {
          padding: 0px 10px 5px 10px;
          background-color: transparent;
          color: transparent;
        }

        .widget-dnd>label {
          color: @color8;
        }

        .widget-dnd>switch {
          background-color: @color1;
        }

        .widget-dnd>switch:checked {
          background-color: @color10;
        }

        .widget-dnd>switch slider {
          background-color: @color1;
          border: 2px solid @foreground;
          border-radius: 99px;
        }

        .notification-row {
          margin: 0px;
          padding: 0px;
          color: @foreground;
        }

        .notification {
          background-color: alpha(@color1, 0.25);
          box-shadow: none;
          margin: 0px;
          border: 2px solid @color06;
          color: @foreground;
        }

        .notification-content {
          padding: 5px;
        }

        .notification-group {
          background-color: transparent;
        }

        .notification-group-icon {
          color: @color15;
        }

        .notification-group-collapse-button,
        .notification-group-close-all-button {
          background-color: @color15;
          border: 2px solid @color15;
        }

        .notification-group.collapsed:hover .notification {
          background-color: @color2;
        }

        .notification-default-action:hover {
          background-color: @color2;
        }

        .notification-action:hover {
          background-color: @color0;
        }

        .notification-default-action:active,
        .notification-action:active {
          background-color: @color2;
        }

        .notification-content .text-box {
          padding: 0px 5px;
        }

        .close-button {
          background-color: @color15;
        }

        .widget-volume {
          background-color: @color1;
          border-radius: 20px;
          margin: 0 10px;
        }

        trough highlight {
          background-color: @foreground;
        }

        scale trough {
          background-color: transparent;
          border: transparent;
          padding: 0px;
          min-height: 5px;
          margin: 0 0 0 10px;
        }

        slider {
          background-color: @color8;
          color: @color8;
          border: 2px solid @foreground;
        }

        .widget-volume label {
          padding: 0 0 0 10px;
        }

        .widget-volume trough highlight {
          background: @color15;
          border: @color8;
        }

        .widget-volume button {
          background-color: inherit;
          box-shadow: unset;
          font-size: 20px;
          padding: 0 20px 0 0;
          border-radius: 99px;
          border: @color8;
          color: @color15;
        }

        .widget-buttons-grid {
          background-color: transparent;
          margin: 0 0 0 278px;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button {
          background-color: transparent;
          border-radius: 99px;
          border: @color8;
          box-shadow: unset;
          min-width: 30px;
          min-height: 30px;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          background-color: @color1;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button:active {
          background-color: @color2;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button label {
          color: @color10;
        }
      '';

    settings = builtins.fromJSON
      # json
      ''
      {
        "$schema": "/etc/xdg/swaync/configSchema.json",
        "positionX": "right",
        "positionY": "bottom",
        "layer": "overlay",
        "control-center-layer": "top",
        "layer-shell": true,
        "cssPriority": "application",
        "control-center-margin-top": 0,
        "control-center-margin-bottom": 0,
        "control-center-margin-right": 0,
        "control-center-margin-left": 0,
        "notification-2fa-action": true,
        "notification-inline-replies": false,
        "notification-icon-size": 64,
        "notification-body-image-height": 160,
        "notification-body-image-width": 250,
        "timeout": 10,
        "timeout-low": 5,
        "timeout-critical": 0,
        "fit-to-screen": false,
        "relative-timestamps": true,
        "control-center-width": 400,
        "control-center-height": 809,
        "notification-window-width": 400,
        "keyboard-shortcuts": true,
        "image-visibility": "when-available",
        "transition-time": 200,
        "hide-on-clear": false,
        "hide-on-action": true,
        "script-fail-notify": true,
        "scripts": {
          "open-screenshot-folder": {
            "exec": "sh -c 'nautilus ~/Pictures/Screenshots'",
            "summary": "Screenshot",
            "run-on": "action"
          }
        },
        "notification-visibility": {
          "example-name": {
            "state": "normal",
            "app-name": "Spotify"
          }
        },
        "widgets": [
          "title",
          "dnd",
          "notifications",
          "volume"
        ],
        "widget-config": {
          "inhibitors": {
            "text": "Inhibitors",
            "button-text": "Clear All",
            "clear-all-button": true
          },
          "title": {
            "text": "Notifications",
            "clear-all-button": true,
            "button-text": "󰎟"
          },
          "dnd": {
            "text": "Do Not Disturb"
          },
          "label": {
            "max-lines": 5,
            "text": "Label Text"
          },
          "mpris": {
            "image-size": 96,
            "image-radius": 12
          },
          "volume": {
            "expand-button-label": "",
            "collapse-button-label": "",
            "show-per-app": true,
            "show-per-app-icon": false,
            "show-per-app-label": true
          }
        }
      }
     '';
  };

  home.packages = with pkgs; [ libnotify ];
}
