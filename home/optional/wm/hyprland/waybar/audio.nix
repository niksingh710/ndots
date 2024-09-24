{ pkgs, lib, ... }: {
  programs.waybar.settings.mainBar = {
    modules-right = [ "group/audio" ];
    "group/audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      "modules" = [ "pulseaudio" "pulseaudio#mic" "pulseaudio/slider" ];
    };
    pulseaudio = {
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
      on-click = "volume mute";
      on-click-middle = "${lib.getExe pkgs.pavucontrol}";
      on-scroll-up = "${
          lib.getExe' pkgs.pulseaudio "pactl"
        } set-sink-volume @DEFAULT_SINK@ +5%";
      on-scroll-down = "${
          lib.getExe' pkgs.pulseaudio "pactl"
        } set-sink-volume @DEFAULT_SINK@ -5%";
      smooth-scrolling-threshold = 1;
    };
    "pulseaudio#mic" = {
      format = "{format_source}";
      format-source = "";
      format-source-muted = "󰍭";
      tooltip-format = "{volume}% {format_source} ";
      on-click =
        "${lib.getExe' pkgs.pulseaudio "pactl"} set-source-mute 0 toggle";
      on-scroll-down =
        "${lib.getExe' pkgs.pulseaudio "pactl"} set-source-volume 0 -1%";
      on-scroll-up =
        "${lib.getExe' pkgs.pulseaudio "pactl"} set-source-volume 0 +1%";
    };
    "pulseaudio/slider" = {
      min = 0;
      max = 140;
      orientation = "vertical";
    };
  };

}
