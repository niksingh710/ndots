{ lib, config, pkgs, ... }:
with lib;
let
  hotspot = pkgs.writeShellApplication {
    name = "hotspot";
    runtimeInputs = [ pkgs.linux-wifi-hotspot ];
    bashOptions = [ "pipefail" ];
    text = let
      hpass = optionalString config.core.sops
        "${config.sops.secrets.hotspot-password.path}";
    in ''
      rcount="$(pkexec --user root create_ap --list-running | wc -l)"

      send() {
        echo "$@"
        notify-send "$@"
      }
      pass="password"
      if [ -f "${hpass}" ]; then
        pass="$(cat ${hpass})"
      fi

      if [ "$rcount" -eq 0 ]; then
        send "No running access points found." "Going to Create one."
        pkexec --user root create_ap wlp0s20f3 enp0s20f0u1u4 '|:-:|' "$pass" --hidden --daemon
      else
        id="$(pkexec --user root create_ap --list-running | cut -d ' ' -f1)"
        send "$rcount: Running access point found." "Going to Stop id: $id"
        pkexec --user root create_ap --stop "$(pkexec --user root create_ap --list-running | cut -d ' ' -f1)"
      fi
      pkill -RTMIN+3 waybar
    '';
  };
in {
  options.wbar.hotspot = mkEnableOption "hotspot";
  config = {
    home.packages = if config.wbar.hotspot then [ hotspot ] else [ ];
    programs.waybar.settings.mainBar = {
      modules-right = [ "group/connection" ];
      "group/connection" = {
        orientation = "inherit";
        modules = [
          (optionalString config.wbar.hotspot "custom/hotspot")
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
      "custom/hotspot" = {
        format = "{} ";
        exec = pkgs.writeShellScript "hotspot-check" ''
          cap="${getExe' pkgs.linux-wifi-hotspot "create_ap"}"
          interface="$(pkexec --user root $cap --list-running | cut -d '(' -f2 | sed 's/)//')"
          if [ -z $interface ]; then
          cat <<EOF
            { "class": "disconnected", "text": " 󱜡", "tooltip": "Hotspot is not running." }
          EOF
          else
            pgrep -x .create_ap-wrap &>/dev/null && {
              list="$(pkexec --user root $cap --list-clients ''${interface})"
              list=$(echo "$list" | sed -z 's/\n/\\n/g')
            }
          cat <<EOF
            { "class": "connected", "text": " 󱜠", "tooltip": "Hotspot is running\n$list" }
          EOF
          fi
        '';
        return-type = "json";
        on-click = "${getExe hotspot}";
        interval = 15;
        signal = 3;
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
        on-click = "killall rofi || ${getExe pkgs.networkmanager_dmenu}";
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
        on-click = "killall rofi || ${getExe pkgs.networkmanager_dmenu}";
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
        on-click = "${getExe pkgs.rofi-bluetooth} -theme bluetooth.rasi -i";
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
        on-click = "${getExe pkgs.rofi-bluetooth} -theme bluetooth.rasi -i";
      };
    };
  };
}
