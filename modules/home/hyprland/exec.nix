{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm finalize"

      # waydroid entries to be forced size to 0 bytes
      "truncate -s 0 ~/.local/share/applications/waydroid.*.desktop"

      "[workspace special:comms silent] sleep 2s && uwsm app -- telegram-desktop"
      "[workspace special:comms silent] sleep 6s && uwsm app -- mailspring"
      "[workspace special:quick silent] sleep 6s && uwsm app -- pavucontrol"

      "${lib.getExe (
        pkgs.writeShellScriptBin "battery-notifier" ''
          "${lib.getExe pkgs.batsignal}" -b \
                  -w 15 -c 5 -d 2 \
                  -W "⚠️ Juice running low! Feed me electrons!" \
                  -C "🔥 Critical power! I’m not gonna make it, Captain!" \
                  -D 'notify-send "💀 SYSTEM FAILURE IMMINENT" "Plug me in or witness the end!" -u critical' \
                  -P "🔌 Charging started. Ahh, sweet electricity!" \
                  -U "🔋 Running on battery. Freedom... but at what cost?"''
      )}"

    ];
  };
}
