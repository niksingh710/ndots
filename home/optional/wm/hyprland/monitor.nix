{ pkgs, lib, ... }: {

  wayland.windowManager.hyprland.settings = {
    
    # TODO: Make this an option configuratble
    monitor = [ "eDP-1,preferred,1920x0,1" "HDMI-A-2,preferred,0x0,1" ];

    workspace = [
      "1,monitor:HDMI-A-2,default:true"
      "2,monitor:HDMI-A-2,default:true"
      "3,monitor:HDMI-A-2,default:true"
      "4,monitor:HDMI-A-2,default:true"
      "5,monitor:HDMI-A-2,default:true"
      "6,monitor:HDMI-A-2,default:true"
      "7,monitor:HDMI-A-2,default:true"
      "8,monitor:HDMI-A-2,default:true"
      "9,monitor:HDMI-A-2,default:true"
      "10,monitor:eDP-1,default:true"
    ];

    exec-once =
      let
        monitor = pkgs.writeShellApplication {
          name = "monitor";
          runtimeInputs = with pkgs; [ jq ];
          text = # bash
            ''
              mon_count=$(hyprctl monitors -j | jq ". | length")

              if [ "$mon_count" -eq 1 ]; then
                exit 0
              fi

              mapfile -t workspaces_on_primary < <(seq 1 9)
              workspaces_on_secondary=(10)

              primary=$(hyprctl monitors -j | jq ".[] | select(.id == 1) | .name")
              secondary=$(hyprctl monitors -j | jq ".[] | select(.id == 0) | .name")

              primary=$(echo "$primary" | tr -d '"')
              secondary=$(echo "$secondary" | tr -d '"')

              for i in "''${workspaces_on_primary[@]}"; do
                hyprctl dispatch moveworkspacetomonitor "$i" "$primary"
              done
              for i in "''${workspaces_on_secondary[@]}"; do
                hyprctl dispatch moveworkspacetomonitor "$i" "$secondary"
              done

              hyprctl dispatch workspace 1
              hyprctl dispatch focusmonitor "$primary"


            '';
        };

        ipc = pkgs.writeShellApplication {
          name = "ipc";
          runtimeInputs = with pkgs; [ libnotify socat jq ];
          bashOptions = [ "pipefail" ];
          text = # bash
            ''

            handle() {
              if [[ ''${1:0:14} == "monitorremoved" ]]; then
                notify "Monitor removed"
                "${lib.getExe monitor}"
              fi

              if [[ ''${1:0:14} == "monitoraddedv2" ]]; then
                notify "Monitor added"
                "${lib.getExe monitor}"
              fi
            }

            socat - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
          '';
        };
      in
      [ "${lib.getExe ipc}" ];
  };
}
