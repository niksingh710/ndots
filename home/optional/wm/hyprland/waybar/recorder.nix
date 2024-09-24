{ pkgs, lib, ... }:
let
  recorder = pkgs.writeShellApplication {
    name = "recorder";
    bashOptions = [ "pipefail" ];
    runtimeInputs = with pkgs; [ wl-screenrec slurp libnotify pulseaudio ];
    text = ''

      notify() {
        notify-send "$@"
        echo "$@"
      }

      if pgrep wl-screenrec &>/dev/null; then
        kill -s SIGINT $(pgrep -x wl-screenrec) && notify "wl-screenrec stopped"
        sleep 1
        pkill -RTMIN+4 waybar
        exit 1
      fi


      audioDevice="$(pactl -f json list sinks | jq ".[] | select(.name==\"$(pactl get-default-sink)\")" | jq '.name').monitor"
      dir="$HOME/Videos/Screencapture"

      [ -d "$dir" ] || mkdir -p "$dir"

      filename="$dir/$(date +%Y-%m-%d___%H-%M-%S).mp4"

      if [ $# -eq 0 ]; then
        dim="$(slurp -o)"
      else
        dim="$(slurp)"
      fi

      if [ -z "$dim" ]; then
        echo "some"
        notify "No area selected"
        exit 1
      fi

      wl-screenrec --audio --audio-device "$audioDevice" -f "$filename" -g "$dim" &

      if pgrep wl-screenrec &>/dev/null; then
        notify "wl-screenrec started"
        pkill -RTMIN+4 waybar
      else
        notify "wl-screenrec failed to start"
      fi
    '';
  };
in {
  home.packages = [ recorder ];
  wayland.windowManager.hyprland.settings.bind = [
    "CTRL,Print,exec,${lib.getExe recorder}"
    "SUPERCTRL,Print,exec,${lib.getExe recorder} -s"
  ];
  programs.waybar.settings.mainBar = {
    modules-right = [ "privacy" "custom/recorder" ];
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
      on-click = "${lib.getExe recorder}";
      signal = 4;
    };
  };
}
