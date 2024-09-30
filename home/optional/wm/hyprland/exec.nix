{ pkgs, lib, config, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec = [
      "${lib.getExe pkgs.killall} swww-daemon;sleep 1; ${
        lib.getExe' pkgs.swww "swww-daemon"
      }"
      "sleep 1 && ${lib.getExe pkgs.swww} img ${config.stylix.image}"
    ];
    exec-once = [

      "[workspace special:comms silent] vesktop"
      "[workspace special:comms silent] sleep 5s && materialgram"
      "[workspace special:comms silent] sleep 5s && whatsapp-for-linux"

      "${lib.getExe pkgs.tmux} has-session -t main || ${
        lib.getExe pkgs.tmux
      } new-session -d -s main"

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
