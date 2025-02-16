{ lib, pkgs, inputs, config, ... }:
let
  utils = inputs.utils.packages.${pkgs.system};
  colorFront = config.lib.stylix.colors.base03;
  vpn = pkgs.writeShellScript "vpn-check" ''
        if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
          gip_data=$(${lib.getExe pkgs.curl} http://ipinfo.io)
          tooltip=$(echo "$gip_data" | ${lib.getExe pkgs.jq} -r '"IP: " + .ip + "\\n" + .city + ", " + .region + ", " + .country')
    cat <<EOF
      { "class": "connected", "text": "<span><small> 󰩠</small></span>", "tooltip": "<b>Vpn is connected</b>\n$tooltip" }
    EOF
        fi
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "CTRL,Print,exec,${lib.getExe' utils.waybar-utils "recorder"}"
    "$modCTRL,Print,exec,${lib.getExe' utils.waybar-utils "recorder"} -s"
  ];

  programs.waybar.settings.mainBar = {
    modules-right = [ "custom/notifications" "privacy" "custom/recorder" "group/brightness" "group/audio" "group/connection" "group/together" "tray" "group/power" ];
    "group/brightness" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [ "backlight" "backlight/slider" ];
    };
    "custom/notifications" = {
      format = "<b>{}</b>";
      tooltip = false;
      exec = "${lib.getExe' pkgs.mako "makoctl"} mode | grep -q 'dnd' && echo '󱏧'|| echo '󰂚' ";
      on-click = "${lib.getExe' pkgs.mako "makoctl"} mode -t dnd";
      on-click-right = "${lib.getExe' pkgs.mako "makoctl"} restore";
      interval = "once";
      signal = 2;
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon}";
      format-icons =
        [ "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ];
      on-scroll-down = "${lib.getExe pkgs.brightnessctl} s 5%-";
      on-scroll-up = "${lib.getExe pkgs.brightnessctl} s +5%";
      tooltip = true;
      tooltip-format = "{percent}% ";
      smooth-scrolling-threshold = 1;
    };
    "backlight/slider" = {
      min = 5;
      max = 100;
      orientation = "vertical";
      device = "intel_backlight";
    };

    "group/audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      "modules" = [ "wireplumber" "pulseaudio#mic" "pulseaudio/slider" ];
    };
    wireplumber = {
      format = "{icon}";
      format-bluetooth = "{icon}";
      tooltip-format = "{volume}% {icon} | {desc}";
      format-muted = "󰖁";
      format-icons = {
        headphones = "󰋌";
        handsfree = "󰋌";
        headset = "󰋌";
        phone = "";
        portable = "";
        car = " ";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
      on-click = "${lib.getExe utils.volume} mute";
      on-click-middle = "${lib.getExe pkgs.pavucontrol}";
      on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+";
      on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-";
      smooth-scrolling-threshold = 1;
    };
    "pulseaudio#mic" = {
      format = "{format_source}";
      format-source = "";
      format-source-muted = "󰍭";
      tooltip-format = "{volume}% {format_source} ";
      on-click =
        "${lib.getExe utils.volume} mic-mute";
      on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 1%+";
      on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 1%-";
    };
    "pulseaudio/slider" = {
      min = 0;
      max = 100;
      orientation = "vertical";
    };
    "group/together" = {
      orientation = "inherit";
      modules = [ "group/utils" "clock" ];
    };
    "group/utils" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
      };
      modules = [
        "custom/mark"
        "custom/weather"
        "custom/colorpicker"
        "idle_inhibitor"
        "custom/hyprkill"
      ];
    };
    "custom/colorpicker" = {
      format = "{}";
      return-type = "json";
      interval = "once";
      exec = "${lib.getExe' utils.waybar-utils "colorpicker"} -j";
      on-click = "sleep 1 && ${lib.getExe' utils.waybar-utils "colorpicker"}";
      signal = 1;
    };

    tray = {
      icon-size = 18;
      spacing = 10;
    };
    "custom/hyprkill" = {
      format = "{}";
      interval = "once";
      exec = ''
        echo "󰅙
        Kill clients using hyrpctl kill"'';
      on-click = "sleep 1 && hyprctl kill";
    };
    "custom/weather" = {
      format = "{}";
      tooltip = true;
      interval = 3600;
      exec = ''
        ${lib.getExe pkgs.wttrbar} --custom-indicator '{ICON}
        {temp_C}' --location noida
      '';
      return-type = "json";
    };
    "custom/mark" = {
      format = "";
      tooltip = false;
    };
    clock = {
      format = ''
        {:%H
        %M}'';
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = { today = "<span color='#${colorFront}'><b><u>{}</u></b></span>"; };
      };
    };
    idle_inhibitor = {
      format = "{icon}";
      tooltip-format-activated = "Idle Inhibitor is active";
      tooltip-format-deactivated = "Idle Inhibitor is not active";
      format-icons = {
        activated = "󰔡";
        deactivated = "󰔢";
      };
    };

    "group/connection" = {
      orientation = "inherit";
      modules = [
        "custom/vpn"
        "group/network"
        "group/bluetooth"
      ];
    };
    "group/network" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
      };
      modules = [ "network" "network#speed" ];
    };

    network = {
      format = "{icon}";
      format-icons = {
        wifi = [ "󰤨" ];
        ethernet = [ "󰈀" ];
        disconnected = [ "󰖪" ];
      };
      format-wifi = "󰤨";
      format-ethernet = "󰈀";
      format-disconnected = "󰖪";
      format-linked = "󰈁";
      tooltip = false;
      on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "network"}";
    };
    "network#speed" = {
      format = " {bandwidthDownBits} ";
      rotate = 90;
      interval = 5;
      tooltip-format = "{ipaddr}";
      tooltip-format-wifi = ''
        {essid} ({signalStrength}%) 
        {ipaddr} | {frequency} MHz{icon} '';
      tooltip-format-ethernet = ''
        {ifname} 󰈀
        {ipaddr} | {frequency} MHz{icon} '';
      tooltip-format-disconnected = "Not Connected to any type of Network";
      tooltip = true;
      on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "network"}";
    };
    "custom/vpn" = {
      signal = 5;
      return-type = "json";
      format = "{} ";
      interval = 5;
      exec = vpn;
    };
    bluetooth = {
      format-on = "";
      format-off = "󰂲";
      format-disabled = "";
      format-connected = "<b></b>";
      tooltip-format = ''
        {controller_alias}	{controller_address}

        {num_connections} connected'';
      tooltip-format-connected = ''
        {controller_alias}	{controller_address}

        {num_connections} connected

        {device_enumerate}'';
      tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
      tooltip-format-enumerate-connected-battery =
        "{device_alias}	{device_address}	{device_battery_percentage}%";
      on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "bluetooth"}";
    };
    "group/bluetooth" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
      };
      modules = [ "bluetooth" "bluetooth#status" ];
    };
    "bluetooth#status" = {
      format-on = "";
      format-off = "";
      format-disabled = "";
      format-connected = "<b>{num_connections}</b>";
      format-connected-battery =
        "<small><b>{device_battery_percentage}%</b></small>";
      tooltip-format = ''
        {controller_alias}	{controller_address}

        {num_connections} connected'';
      tooltip-format-connected = ''
        {controller_alias}	{controller_address}

        {num_connections} connected

        {device_enumerate}'';
      tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
      tooltip-format-enumerate-connected-battery =
        "{device_alias}	{device_address}	{device_battery_percentage}%";
      on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "bluetooth"}";
    };
    privacy = {
      orientation = "vertical";
      icon-spacing = 4;
      icon-size = 14;
      transition-duration = 250;
      modules = [{
        "type" = "screenshare";
        "tooltip" = true;
        "tooltip-icon-size" = 24;
      }];
    };
    "custom/recorder" = {
      format = "{}";
      interval = "once";
      exec = "echo ''";
      tooltip = "false";
      exec-if = "pgrep -x wl-screenrec";
      on-click = "${lib.getExe' utils.waybar-utils "recorder"}";
      signal = 4;
    };
    "group/power" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [ "battery" ];
    };
    battery = {
      rotate = 270;
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon}";
      format-charging = "<b>{icon} </b>";
      format-full = "<span color='#82A55F'><b>{icon}</b></span>";
      format-icons = [
        "󰁻"
        "󰁻"
        "󰁼"
        "󰁼"
        "󰁾"
        "󰁾"
        "󰂀"
        "󰂀"
        "󰂂"
        "󰂂"
        "󰁹"
      ];
      tooltip-format = "{timeTo} {capacity} % | {power} W";
    };
  };
}
