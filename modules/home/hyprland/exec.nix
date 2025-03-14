{ pkgs, lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm finalize"

      # waydroid entries to be forced size to 0 bytes
      "truncate -s 0 ~/.local/share/applications/waydroid.*.desktop"

      "[workspace special:comms silent] sleep 2s && uwsm app -- materialgram"
      "[workspace special:comms silent] sleep 6s && uwsm app -- mailspring"
      "[workspace special:quick silent] sleep 6s && uwsm app -- pavucontrol"

      "${lib.getExe pkgs.batsignal}"
    ];
  };
}
