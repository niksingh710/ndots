{ config, ... }:
let
  colors = ''
    @define-color background #${config.stylix.base16Scheme.base00};
    @define-color foreground #${config.stylix.base16Scheme.base0F};
    @define-color cursor #${config.stylix.base16Scheme.base00};
     
    @define-color color0 #${config.stylix.base16Scheme.base00};
    @define-color color1 #${config.stylix.base16Scheme.base01};
    @define-color color2 #${config.stylix.base16Scheme.base02};
    @define-color color3 #${config.stylix.base16Scheme.base03};
    @define-color color4 #${config.stylix.base16Scheme.base04};
    @define-color color5 #${config.stylix.base16Scheme.base05};
    @define-color color6 #${config.stylix.base16Scheme.base06};
    @define-color color7 #${config.stylix.base16Scheme.base07};
    @define-color color8 #${config.stylix.base16Scheme.base08};
    @define-color color9 #${config.stylix.base16Scheme.base09};
    @define-color color10 #${config.stylix.base16Scheme.base0A};
    @define-color color11 #${config.stylix.base16Scheme.base0B};
    @define-color color12 #${config.stylix.base16Scheme.base0C};
    @define-color color13 #${config.stylix.base16Scheme.base0D};
    @define-color color14 #${config.stylix.base16Scheme.base0E};
    @define-color color15 #${config.stylix.base16Scheme.base0F};
    @define-color active #${config.stylix.base16Scheme.base0D};
    @define-color inactive #${config.stylix.base16Scheme.base03};

  '';
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
        border-radius: 8px;
        border: 2px solid @active;
        background: @background;
        background: alpha(@background, 0.7);
        color: lighter(@active);
      }

      menu,
      tooltip {
        border-radius: 8px;
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
        border-radius: 4px;
        background: alpha(@background, 0.4);
        color: lighter(@active);
        /* padding: 2px 0 0 2px; */

        padding: 2px 2px 4px 2px;
      }

      .modules-left {
        transition-property: background-color;
        transition-duration: 0.5s;
        margin: 6px 6px 6px 6px;
        border-radius: 4px;
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
        border-radius: 4px;
        background: alpha(darker(@active), 0.3);
      }

      #audio {
        margin-top: 3px;
      }

      #brightness,
      #audio {
        border-radius: 4px;
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
        border-radius: 8px;
      }

      #workspaces button {
        transition-property: background-color;
        transition-duration: 0.5s;
        color: @foreground;
        background: transparent;
        border-radius: 4px;
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
        border-radius: 4px;
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
        border-radius: 8px;
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
        border-radius: 4px;
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
        border-radius: 8px;
        background-color: alpha(@background, 0.6);
      }

      #backlight-slider highlight,
      #pulseaudio-slider highlight {
        border-radius: 8px;
        background-color: lighter(@active);
      }

      #bluetooth.discoverable,
      #bluetooth.discovering,
      #bluetooth.pairable {
        border-radius: 8px;
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
