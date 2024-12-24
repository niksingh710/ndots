{ pkgs, lib, config, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec = [
      "${lib.getExe pkgs.killall} swww-daemon;sleep 1;uwsm app -- ${
        lib.getExe' pkgs.swww "swww-daemon"
      }"
      "sleep 1 && uwsm app -- ${lib.getExe pkgs.swww} img ${config.stylix.image}"
    ];
    exec-once = [

      # waydroid entries to be forced size to 0 bytes
      "truncate -s 0 ~/.local/share/applications/waydroid.*.desktop"
      "[workspace special:comms silent] sleep 2s && uwsm app -- materialgram"
      "[workspace special:comms silent] sleep 6s && uwsm app -- fractal"
      "[workspace special:comms silent] sleep 6s && uwsm app -- dissent"

      "${lib.getExe pkgs.batsignal}"

      "uwsm app -- ${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type text --watch cliphist store"
      "uwsm app -- ${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type image --watch cliphist store"
      "uwsm app -- ${
        lib.getExe' pkgs.wl-clipboard "wl-paste"
      } --type application/pdf --watch cliphist store"

    ];
  };
}
