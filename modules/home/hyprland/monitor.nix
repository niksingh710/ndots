{ lib, inputs, pkgs, config, ... }:
let
  cfg = config.ndots.hyprland.monitor;
  utils = inputs.utils.packages.${pkgs.system};
in
{
  options.ndots.hyprland.monitor = {
    primary = lib.mkOption {
      type = lib.types.str;
      default = "HDMI-A-2";
      description = ''
        Primary monitor string
      '';
    };
    secondary = lib.mkOption {
      type = lib.types.str;
      default = "eDP-1";
      description = ''
        Secondary monitor string
      '';
    };
  };

  config = {

    wayland.windowManager.hyprland.settings = {
      monitor = [ "${cfg.secondary},preferred,1920x0,1" "${cfg.primary},preferred,0x0,1" ];

      workspace = [
        "1,monitor:${cfg.primary},default:true"
        "2,monitor:${cfg.primary},default:true"
        "3,monitor:${cfg.primary},default:true"
        "4,monitor:${cfg.primary},default:true"
        "5,monitor:${cfg.primary},default:true"
        "6,monitor:${cfg.primary},default:true"
        "7,monitor:${cfg.primary},default:true"
        "8,monitor:${cfg.primary},default:true"
        "9,monitor:${cfg.primary},default:true"
        "10,monitor:${cfg.secondary},default:true"
      ];
      exec = [
        "sleep 5s && ${lib.getExe (pkgs.writeShellApplication
          {
            name = "ipc";
            runtimeInputs = with pkgs; [ libnotify socat jq ];
            bashOptions = [ "pipefail" ];
            text = # bash
              ''
                handle() {
                  if [[ ''${1:0:14} == "monitorremoved" ]]; then
                    notify "Monitor removed"
                    "${lib.getExe utils.monitor}"
                  fi

                  if [[ ''${1:0:14} == "monitoraddedv2" ]]; then
                    notify "Monitor added"
                    "${lib.getExe utils.monitor}"
                  fi
                }

                socat - \
                UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | \
                while read -r line; do handle "$line"; done
              '';
          })}"
      ];
    };
  };
}
