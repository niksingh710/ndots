{ pkgs, lib, config, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec = [
      "${lib.getExe pkgs.killall} swww-daemon;sleep 1; ${
        lib.getExe' pkgs.swww "swww-daemon"
      }"
      "sleep 1 && ${lib.getExe pkgs.swww} img ${config.stylix.image}"
    ];
    exec-once = [

      # waydroid entries to be forced size to 0 bytes
      "truncate -s 0 ~/.local/share/applications/waydroid.*.desktop"
      "[workspace special:comms silent] telegram-desktop"
      "[workspace special:comms silent] sleep 3s && fractal"
      "[workspace special:comms silent] sleep 3s && vesktop"

      "${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type text --watch cliphist store"
      "${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type image --watch cliphist store"
      "${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type application/pdf --watch cliphist store"

    ];
  };
}
