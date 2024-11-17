{ pkgs, config, ... }: {
  persist.dir = [ ".config/swaync" ];
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

        @import 'themes/notifications.css';
        @import 'themes/central_control.css';
      '';

    settings = builtins.fromJSON
      # json
      ''
        {
          "$schema": "/etc/xdg/swaync/configSchema.json",
          "positionX": "right",
          "positionY": "bottom",
          "control-center-margin-top": 2,
          "control-center-margin-bottom": 2,
          "control-center-margin-right": 1,
          "control-center-margin-left": 0,
          "notification-icon-size": 64,
          "notification-body-image-height": 160,
          "notification-body-image-width": 200,
          "timeout": 6,
          "timeout-low": 4,
          "timeout-critical": 0,
          "fit-to-screen": false,
          "control-center-width": 400,
          "control-center-height": 660,
          "notification-window-width": 400,
          "keyboard-shortcuts": true,
          "image-visibility": "when-available",
          "transition-time": 500,
          "hide-on-clear": true,
          "hide-on-action": true,
          "script-fail-notify": true,
          "notification-visibility": {
            "example-name": {
              "state": "muted",
              "urgency": "Low",
              "app-name": "Spotify"
            }
          },
          "widgets": [
            "mpris",
            "title",
            "dnd",
            "notifications"
          ],
          "widget-config": {
            "title": {
              "text": "Notifications",
              "clear-all-button": true,
              "button-text": " 󰎟 "
            },
            "dnd": {
              "text": "Do not disturb"
            },
            "mpris": {
              "image-size": 96,
              "image-radius": 6
            }
          }
        }
      '';
  };

  home = {
    packages = with pkgs; [ libnotify ];
    file = {
      ".config/swaync/themes/central_control.css".text = # css
        ''
          @define-color text @foreground;
          @define-color background-alt @color1;
          @define-color selected @color3;
          @define-color hover @color5;
          @define-color urgent @color2;

          * {
            color: @text;

            all: unset;
            font-size: 14px;
            font-family: "JetBrains Mono Nerd Font 10";
            transition: 200ms;
          }

          /* Avoid 'annoying' backgroud */
          .blank-window {
            background: transparent;
          }

          /* CONTROL CENTER ------------------------------------------------------------------------ */

          .control-center {
            background: alpha(@background, 0.35);
            border: 2px solid @color6;
            border-radius: 8px;
            margin: 8px;
            padding: 4px;
          }

          /* Notifications  */
          .control-center .notification-row .notification-background,
          .control-center .notification-row .notification-background .notification.critical {
            background-color: alpha(@background, 0.9);
            border-radius: 8px;
            border: 2px solid @color6;
            margin: 2px 0px;
            padding: 2px;
          }

          .control-center .notification-row .notification-background .notification.critical {
            color: @urgent;
          }

          .control-center .notification-row .notification-background .notification .notification-content {
            margin: 4px;
            padding: 6px 4px 2px 2px;
          }

          .control-center .notification-row .notification-background .notification>*:last-child>* {
            min-height: 3.4em;
          }

          .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action {
            background: @background-alt;
            color: @text;
            border-radius: 8px;
            margin: 6px;
            border: 2px solid transparent;
          }

          .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
            color: @background;
          }

          .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
            background-color: @selected;
            color: @background;
          }

          /* Buttons */

          .control-center .notification-row .notification-background .close-button {
            border: 1px solid transparent;
            background: transparent;
            border-radius: 50%;
            color: @selected;
            margin: 0px;
            padding: 4px;
          }

          .control-center .notification-row .notification-background .close-button:hover {
            background-color: @background;
            border: 1px solid @color6;
          }

          .control-center .notification-row .notification-background .close-button:active {
            background-color: @selected;
            color: @background;
          }

          progressbar,
          progress,
          trough {
            border-radius: 8px;
          }

          progressbar {
            background-color: rgba(255, 255, 255, 0.1);
          }

          /* Notifications expanded-group */

          .notification-group {
            margin: 2px 8px 2px 8px;
          }

          .notification-group-headers {
            font-weight: bold;
            font-size: 1.25rem;
            color: @text;
            letter-spacing: 2px;
            margin-bottom: 16px;
          }

          .notification-group-icon {
            color: @text;
          }

          .notification-group-collapse-button,
          .notification-group-close-all-button {
            background: transparent;
            margin: 4px;
            border: 2px solid transparent;

            border-radius: 50%;
            padding: 4px;
          }

          .notification-group-collapse-button:hover,
          .notification-group-close-all-button:hover {
            background: alpha(@text, 0.2);
            border: 2px solid @color6;
          }

          /* WIDGETS --------------------------------------------------------------------------- */

          /* Notification clear button */
          .widget-title {
            font-size: 1.2em;
            margin: 2px;
          }

          .widget-title button {
            border-radius: 10px;
            padding: 4px 16px;
            border: 2px solid @color6;
          }

          .widget-title button:hover {
            background-color: alpha(@text, 0.2);
            border: 2px solid @color6;
          }

          .widget-title button:active {
            background-color: @selected;
            color: @background;
          }

          /* Do not disturb */
          .widget-dnd {
            margin: 8px 2px;
            font-size: 1.2rem;
          }

          .widget-dnd>switch {
            font-size: initial;
            border-radius: 8px;
            border: 2px solid @color6;
          }

          .widget-dnd>switch:hover {
            background: alpha(@color6, 0.2);
          }

          .widget-dnd>switch:checked {
            background: @color6;
          }

          .widget-dnd>switch:checked:hover {
            background: alpha(@color6, 0.8);
          }

          .widget-dnd>switch slider {
            background: darker(@color6);
            border-radius: 6px;
          }

          /* Buttons menu */
          .widget-buttons-grid {
            font-size: x-large;
            padding: 6px 2px;
            margin: 6px;
            border-radius: 12px;
            background: alpha(@selected, 0.2);
          }

          .widget-buttons-grid>flowbox>flowboxchild>button {
            margin: 4px 10px;
            padding: 6px 12px;
            background: transparent;
            border-radius: 8px;
            border: 2px solid transparent;
          }

          .widget-buttons-grid>flowbox>flowboxchild>button:hover {
            background: alpha(@background-alt, 0.6);
          }

          /* Music player */
          .widget-mpris {
            background: alpha(@color6, 0.2);
            border-radius: 8px;
            color: @color6;
            padding: 0px;
            margin: 10px 6px;
          }

          .widget-mpris button {
            color: alpha(@text, 0.6);
            border-radius: 6px;
          }

          .widget-mpris button:hover {
            color: @text;
          }

          /* NOTE: Background need *opacity 1* otherwise will turn into the album art blurred  */
          .widget-mpris-player {
            background: @selected;
            padding: 6px 10px;
            margin: 10px;
            border-radius: 14px;
          }

          .widget-mpris-album-art {
            border-radius: 16px;
          }

          .widget-mpris-title {
            font-weight: 700;
            font-size: 1rem;
          }

          .widget-mpris-subtitle {
            font-weight: 500;
            font-size: 0.8rem;
          }

          /* Volume */
          .widget-volume {
            background: @background-alt;
            color: @background;
            padding: 4px;
            margin: 6px;
            border-radius: 6px;
          }
        '';
      ".config/swaync/themes/notifications.css".text = # css
        ''

          @define-color text            @foreground;
          @define-color background-alt  @color1;
          @define-color selected        @color3;
          @define-color hover           @color5;
          @define-color urgent          @color2;

          * {

            /*background-alt:        @color1;      Buttons background */
            /*selected:              @color2;      Button selected */
            /*hover:                 @color5;      Hover button */
            /*urgent:                @color6;      Urgency critical */
            /*text-selected:         @background; */

            color: @text;

            all: unset;
            font-size: 14px;
            font-family: "JetBrains Mono Nerd Font 10";
            transition: 200ms;

          }

          .notification-row {
            outline: none;
            margin: 0;
            padding: 0px;
          }

          .floating-notifications.background .notification-row .notification-background {
            background: alpha(@background, .35);
            border: 1px solid @color6;
            border-radius: 12px;
            margin: 16px;
            padding: 0;
          }

          .floating-notifications.background .notification-row .notification-background .notification {
            padding: 6px;
            border-radius: 12px;
          }

          .floating-notifications.background .notification-row .notification-background .notification.critical {
            border: 2px solid @urgent;
          }

          .floating-notifications.background .notification-row .notification-background .notification .notification-content {
            margin: 14px;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
            min-height: 3.4em;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
            border-radius: 8px;
            background-color: @background-alt ;
            margin: 6px;
            border: 1px solid transparent;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
            background-color: @hover;
            border: 1px solid @selected;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
            background-color: @selected;
            color: @background;
          }

          .image {
            margin: 10px 20px 10px 0px;
          }

          .summary {
            font-weight: 800;
            font-size: 1rem;
          }

          .body {
            font-size: 0.8rem;
          }

          .floating-notifications.background .notification-row .notification-background .close-button {
            margin: 6px;
            padding: 2px;
            border-radius: 6px;
            border: 1px solid transparent;
          }

          .floating-notifications.background .notification-row .notification-background .close-button:hover {
            background-color: @selected;
          }

          .floating-notifications.background .notification-row .notification-background .close-button:active {
            background-color: @selected;
            color: @background;
          }

          .notification.critical progress {
            background-color: @selected;
          }

          .notification.low progress,
          .notification.normal progress {
            background-color: @selected;
          }
        '';
      /* ".config/swaync/style.css".text = */
      /*   let */
      /*     inherit (config.lib.stylix) colors; */
      /*     # css */
      /*   in */
      /*   '' */
      /**/
      /*   @define-color background #${colors.base00}; */
      /*   @define-color foreground #${colors.base0F}; */
      /*   @define-color cursor #${colors.base00}; */
      /**/
      /*   @define-color color0 #${colors.base00}; */
      /*   @define-color color1 #${colors.base01}; */
      /*   @define-color color2 #${colors.base02}; */
      /*   @define-color color3 #${colors.base03}; */
      /*   @define-color color4 #${colors.base04}; */
      /*   @define-color color5 #${colors.base05}; */
      /*   @define-color color6 #${colors.base06}; */
      /*   @define-color color7 #${colors.base07}; */
      /*   @define-color color8 #${colors.base08}; */
      /*   @define-color color9 #${colors.base09}; */
      /*   @define-color color10 #${colors.base0A}; */
      /*   @define-color color11 #${colors.base0B}; */
      /*   @define-color color12 #${colors.base0C}; */
      /*   @define-color color13 #${colors.base0D}; */
      /*   @define-color color14 #${colors.base0E}; */
      /*   @define-color color15 #${colors.base0F}; */
      /*   @define-color active #${colors.base0F}; */
      /*   @define-color inactive #${colors.base03}; */
      /**/
      /*   @import 'themes/notifications.css'; */
      /*   @import 'themes/central_control.css'; */
      /* ''; */
    };
  };
}
