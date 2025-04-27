{ config, opts, ... }:
let
  radius = if opts.rounding then "8px" else "0px";
  radius-small = if opts.rounding then "4px" else "0px";
  colors = (
    with config.lib.stylix.colors;
    # scss
    ''
      @define-color background #${base00};
      @define-color foreground #${base0F};
      @define-color cursor #${base00};

      @define-color color0 #${base00};
      @define-color color1 #${base01};
      @define-color color2 #${base02};
      @define-color color3 #${base03};
      @define-color color4 #${base04};
      @define-color color5 #${base05};
      @define-color color6 #${base06};
      @define-color color7 #${base07};
      @define-color color8 #${base08};
      @define-color color9 #${base09};
      @define-color color10 #${base0A};
      @define-color color11 #${base0B};
      @define-color color12 #${base0C};
      @define-color color13 #${base0D};
      @define-color color14 #${base0E};
      @define-color color15 #${base0F};
      @define-color active #${base06};
      @define-color inactive #${base03};

    ''
  );

  alphaValue = config.stylix.opacity.popups;
in
{
  programs.waybar.style = # css
    ''
      ${colors}
      * {
        min-width: 8px;
        min-height: 0px;
      }

      window#waybar {
        transition-property: background-color;
        transition-duration: 0.5s;
        border-radius: ${radius};
        border: 2px solid @active;
        background: alpha(@background, ${builtins.toString alphaValue});
        color: lighter(@active);
      }

      menu,
      tooltip {
        border-radius: ${radius};
        padding: 2px;
        border: 1px solid lighter(@active);
        background: alpha(@background, 0.6);

        color: lighter(@active);
      }

      menu label,
      tooltip label {
        font-size: 14px;
        color: lighter(@active);
      }

      #submap,
      #tray>.needs-attention {
        animation-name: blink-active;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      .modules-right {
        margin: 0px 6px 6px 6px;
        border-radius: ${radius-small};
        background: alpha(@background, 0.4);
        color: lighter(@active);
        padding: 2px 2px 4px 2px;
      }

      .modules-left {
        transition-property: background-color;
        transition-duration: 0.5s;
        margin: 6px 6px 6px 6px;
        border-radius: ${radius-small};
        background: alpha(@background, 0.4);
        color: lighter(@active);
      }

      #gcpu,
      #custom-github,
      #custom-notifications,
      #memory,
      #disk,
      #together,
      #submap,
      #custom-weather,
      #custom-recorder,
      #connection,
      #cnoti,
      #power,
      #custom-updates,
      #tray,
      #privacy {
        margin: 3px 0px;
        border-radius: ${radius-small};
        background: alpha(darker(@active), 0.3);
      }

      #audio {
        margin-top: 3px;
      }

      #brightness,
      #audio {
        border-radius: ${radius-small};
        background: alpha(darker(@active), 0.3);
      }

      #custom-notifications {
        padding-right: 4px;
      }

      #custom-hotspot,
      #custom-github,
      #custom-notifications {
        font-size: 14px;
      }

      #custom-hotspot {
        padding-right: 2px;
      }

      #custom-vpn,
      #custom-hotspot {
        background: alpha(darker(@active), 0.3);
      }

      #privacy-item {
        padding: 6px 0px 6px 6px;
      }

      #gcpu {
        padding: 8px 0px 8px 0px;
      }

      #custom-cpu-icon {
        font-size: 25px;
      }

      #custom-cputemp,
      #disk,
      #memory,
      #cpu {
        font-size: 14px;
        font-weight: bold;
      }

      #custom-github {
        padding-top: 2px;
        padding-right: 4px;
      }

      #custom-dmark {
        color: alpha(@foreground, 0.3);
      }

      #submap {
        margin-bottom: 0px;
      }

      #workspaces {
        margin: 0px 2px;
        padding: 4px 0px 0px 0px;
        border-radius: ${radius};
      }

      #workspaces button {
        transition-property: background-color;
        transition-duration: 0.5s;
        color: @foreground;
        background: transparent;
        border-radius: ${radius-small};
        color: alpha(@foreground, 0.3);
      }

      #workspaces button.urgent {
        font-weight: bold;
        color: @foreground;
      }

      #workspaces button.active {
        padding: 4px 2px;
        background: alpha(@active, 0.4);
        color: lighter(@active);
        border-radius: ${radius-small};
      }

      #network.wifi {
        padding-right: 4px;
      }

      #submap {
        min-width: 0px;
        margin: 4px 6px 4px 6px;
      }

      #custom-weather,
      #tray {
        padding: 4px 0px 4px 0px;
      }

      #bluetooth {
        padding-top: 2px;
      }

      #battery {
        border-radius: ${radius};
        padding: 4px 0px;
        margin: 4px 2px 4px 2px;
      }

      #battery.discharging.warning {
        animation-name: blink-yellow;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.discharging.critical {
        animation-name: blink-red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #clock {
        font-weight: bold;
        padding: 4px 2px 2px 2px;
      }

      #pulseaudio.mic {
        border-radius: ${radius-small};
        color: @background;
        background: alpha(darker(@foreground), 0.6);
      }

      #backlight-slider slider,
      #pulseaudio-slider slider {
        background-color: transparent;
        box-shadow: none;
      }

      #backlight-slider trough,
      #pulseaudio-slider trough {
        margin-top: 4px;
        min-width: 6px;
        min-height: 60px;
        border-radius: ${radius};
        background-color: alpha(@background, 0.6);
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        border-radius: ${radius};
        background-color: lighter(@active);
      }

      #bluetooth.discoverable,
      #bluetooth.discovering,
      #bluetooth.pairable {
        border-radius: ${radius};
        animation-name: blink-active;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink-active {
        to {
          background-color: @active;
          color: @foreground;
        }
      }

      @keyframes blink-red {
        to {
          background-color: #c64d4f;
          color: @foreground;
        }
      }

      @keyframes blink-yellow {
        to {
          background-color: #cf9022;
          color: @foreground;
        }
      }
    '';
}
