{ lib, pkgs, ... }:
let
  clipString = ''
    /^[0-9]+\s<meta http-equiv=/ { next }
    match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
        system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
        print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
        next
    }
    1
  '';

  scripts = {
    # TODO: Create a new clipboard client for wayland in rust
    clipboard = pkgs.writeShellApplication {
      name = "clipboard";
      runtimeInputs = with pkgs; [ cliphist wl-clipboard rofi-wayland gawk ];
      bashOptions = [ "pipefail" ];
      text = # bash
        ''
          # This script will output raw data in a format so rofi can preview image
          tmp_dir="/tmp/cliphist"
          rm -rf "$tmp_dir"

          if [[ -n "$1" ]]; then
              cliphist decode <<<"$1" | wl-copy
              exit
          fi

          mkdir -p "$tmp_dir"

          read -r -d "" prog <<EOF
            ${clipString}
          EOF
          cliphist list | gawk "$prog"
        '';
    };

    goto-client = pkgs.writeShellApplication {
      name = "goto-client";
      runtimeInputs = with pkgs; [ jq rofi-wayland ];
      bashOptions = [ "pipefail" ];
      text = # bash
        ''
          hyprctl clients -j | jq -r '.[] 
            | select(.mapped==true) 
            | select((.workspace.name | contains("special") | not) or (.workspace.name == "special:comms"))
            | .class + " - " + (.pid|tostring) + " - " + .title' 

          out=$(echo "$1" | awk '{print $3}')
          [ -z "$out" ] || {
            killall -q rofi &>/dev/null
            hyprctl dispatch focuswindow "pid:$out"
            hyprctl dispatch alterzorder top,"pid:$out"
          }
          exit 0
        '';
    };

    get-client = pkgs.writeShellApplication {
      name = "get-client";
      runtimeInputs = with pkgs; [ jq rofi-wayland ];
      bashOptions = [ "pipefail" ];
      text = ''

        _current_workspace="$(hyprctl monitors -j | jq '.[] | select(.focused==true)' | jq -j '.activeWorkspace.name')"

        killall -q rofi && exit

        clients() {
          hyprctl clients -j | jq -r '.[] 
          | select(.mapped==true) 
          | select((.workspace.name | contains("special") | not) or (.workspace.name == "special:comms"))
          | .class + " - " + (.pid|tostring) + " - " + .title'
        }

        out=$(
          clients |
            rofi -dmenu |
            awk '{print $3}'
        )

        [ -z "$out" ] || {
          hyprctl dispatch moveoutofgroup "pid:$out" &>/dev/null
          hyprctl dispatch movetoworkspace "$_current_workspace,pid:$out" &>/dev/null
          hyprctl dispatch alterzorder top,"pid:$out" &>/dev/null
        }
      '';
    };
    audio-channel = pkgs.writeShellApplication {
      name = "audio-channel";
      runtimeInputs = with pkgs; [ rofi-wayland pulseaudio jq ];
      bashOptions = [ "pipefail" ];
      text = # bash
        ''
          # Get the list of available sinks, prepending each with an index
          sink_list=$(pactl list sinks)
          devices=$(printf '%s\n' "''${sink_list}" | awk -F'= ' '/device.description/ {print ++i, $2}' | tr -d '"')

          readarray -t arr <<<"''${devices}"
          curr="$(pactl -f json list sinks | jq ".[] | select(.name==\"$(pactl get-default-sink)\")" | jq '.["properties"]["device.description"]' | tr -d '\"')"

          str=""
          for i in "''${arr[@]}"; do
          	currsel="$(echo "$i" | cut -d " " -f 2-)"
          	id="$(echo "$i" | cut -d " " -f 1)"
          	if [[ "$currsel" = "$curr" ]]; then
          		str+="$id  $currsel\n"
          	else
          		str+="$id $currsel\n"
          	fi
          done

          # Prompt the user for a device, storing the id of the selected option
          selected_id=$(echo -e "$str" | rofi -dmenu -i -p "Choose Device ::" -theme audio-channel.rasi | awk '{print $1}')
          [ -n "''${selected_id}" ] || exit

          # Get the sink id of the selected device and change the default sink
          sink_id=$(printf '%s\n' "''${sink_list}" | awk -F'= ' '/object.serial/ {print $2}' | tr -d '"' | sed -n "''${selected_id}p")
          pactl set-default-sink "''${sink_id}"
        '';
    };
    client-kill = pkgs.writeShellApplication {
      name = "client-kill";
      runtimeInputs = with pkgs; [ jq rofi-wayland ];
      bashOptions = [ "pipefail" ];
      text = # bash
        ''
          killall -q rofi && exit

          clients() {
            hyprctl clients -j | jq -r '.[]
            | select(.mapped==true) 
            | select(.workspace.name | contains("special") | not)
            | .class + " - " + (.pid|tostring) + " - " + .title'
          }

          out=$(clients |
            rofi -dmenu -p "Kill:" |
            awk '{print $3}')

          [ -z "$out" ] || kill -9 "$out" && echo "none selected"
        '';
    };
    powermenu = pkgs.writeShellApplication {
      name = "powermenu";
      runtimeInputs = with pkgs; [ rofi-wayland ];
      bashOptions = [ "pipefail" ];
      text = # bash
        ''
            check() {
              command -v "$1" &>/dev/null
            }
            # shellcheck disable=SC2015
            notify() {
              check notify-send && notify-send -u low -t 3000 "$1" || {
                echo "$1"
              }
            }

            check rofi || {
              notify "Rofi not Found"
              exit 1
            }

            killall -q rofi

          # Current Theme
            dir="$HOME/.config/rofi/"
            conf='powermenu-conf'

          # CMDs
            uptime="$(uptime | sed -e 's/up //g' | cut -f2 -d ' ')"
            check hostname && ifhost=$(hostname) || ifhost=""

          # Options
            shutdown='󰐦'
            reboot='󰑓'
            lock=''
            suspend='󰒲'
            logout='󰿅'

          # Rofi CMD
            rofi_cmd() {
              rofi -dmenu \
                -p "Goodbye ''${USER}" \
                -mesg "Uptime $ifhost: $uptime" \
                -config "''${dir}"/"''${conf}".rasi
            }

          # Pass variables to rofi dmenu
            run_rofi() {
              echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
            }

            cleanup() {
              # This is a function that will fix any error that occurs after logout login

              # Rclone fuser drives needs to be unmounted before logout
              mapfile -t mounted_rclones < <(grep fuse.rclone /etc/mtab | awk '{print $2}')
              # mounted_rclones=($(grep fuse.rclone /etc/mtab | awk '{print $2}'))
              printf '%s\n' "''${mounted_rclones[@]}" | while IFS= read -r line; do
                fusermount -uq "$line"
              done
              killall -q zellij
              check tmux && tmux kill-server
              killall -q tmux
              killall -q swayidle
              killall -q swww
              check hyprctl && hyprctl dispatch exit none
            }

            logout_fn() {
              # TODO: use hyprland post exit feature
              cleanup
              sudo pkill -9 -u "$(whoami)"
              # loginctl terminate-session "$(loginctl session-status | head -n 1 | awk '{print $1}')"
              # pkill -KILL -u niksingh710
            }

            [[ $1 == "-l" ]] && logout_fn && exit 0

          # Actions
            chosen="$(run_rofi)"
            case ''${chosen} in
            "$shutdown")
              systemctl poweroff
              ;;
            "$reboot")
              systemctl reboot
              ;;
            "$lock")
              sleep .5s
              loginctl lock-session
              ;;
            "$suspend")
              if pgrep -x create_ap; then
                loginctl lock-session
                sleep 1
                hyprctl dispatch dpms off
              else
                systemctl suspend
              fi
              ;;
            "$logout")
              logout_fn
              ;;
              esac
        '';
    };
  };
  rofi-bin = "${lib.getExe pkgs.rofi-wayland}";
in {
  imports = [ ./config.nix ];
  home = {
    file.".config/networkmanager-dmenu/config.ini".text = # ini
      ''
        [dmenu]
        dmenu_command = ${
          lib.getExe pkgs.rofi-wayland
        } -dmenu -i -l 10 -theme network.rasi
        compact = True
        wifi_chars = ▂▄▆█
        active_chars = 

        [dmenu_passphrase]
        obscure = True
        obscure_color = #222222

        [editor]
        terminal = foot

        [nmdm]
        # rescan_delay = <seconds>  # (seconds to wait after a wifi rescan before redisplaying the results)
      '';
    packages = (with pkgs; [ cliphist wl-clipboard rofi-wayland gawk ])
      ++ [ scripts.clipboard ];
  };
  wayland.windowManager.hyprland = {
    extraConfig = ''
      $submapreset = hyprctl dispatch submap reset

      bind = ALT,SPACE,submap,HLeader
      submap = HLeader # denotes HyprLeader

      # -- Rofi section in submap
      $rofi = killall rofi || ${lib.getExe pkgs.rofi}

      bind = ,n,exec,$submapreset;killall rofi || ${
        lib.getExe pkgs.networkmanager_dmenu
      }
      # bind = SHIFT,n,exec,$submapreset;which swaync && swaync-client -t -sw
      bind = ,b,exec,$submapreset;killall rofi || ${
        lib.getExe pkgs.rofi-bluetooth
      } -theme bluetooth.rasi -i
      bind = ,period,exec,$submapreset;killall -q rofi;${
        lib.getExe pkgs.rofimoji
      } -f kaomoji
      bind = SHIFT,a,exec,$submapreset;killall rofi || rofi -show drun -theme menu-full.rasi
      bind = ,a,exec,$submapreset;${lib.getExe scripts.audio-channel}
      # bind = ,c,exec,$submapreset;$rofi -show calc -modi calc -no-show-match -no-sort
      bind = ,k,exec,$submapreset;${lib.getExe scripts.client-kill}
      bind = ,escape,exec,hyprctl dispatch submap reset; killall rofi
      bind = ALT,SPACE,exec,hyprctl dispatch submap reset; killall rofi
      bind = SUPER,SPACE,exec,hyprctl dispatch submap reset; killall rofi
      bind = ,p,exec,$submapreset;${lib.getExe pkgs.playerctl} play-pause

      submap = reset
    '';
    settings = {
      "$rofi" = "killall rofi || rofi";
      "$submapreset" = "hyprctl dispatch submap reset";
      bind = [

        "SUPERSHIFT,E,exec,${lib.getExe scripts.powermenu}"
        "$modSHIFT,V,exec,${lib.getExe pkgs.cliphist} wipe"
        ''
          $mod,V,exec,${lib.getExe scripts.clipboard} | ${
            lib.getExe pkgs.rofi-wayland
          } -dmenu -i -p "clipboard" -display-columns 2 | cliphist decode | wl-copy;''

        ''
          $mod,period,exec,killall -q ${rofi-bin} || ${
            lib.getExe pkgs.rofimoji
          } --selector-args="-theme grid.rasi" --hidden-descriptions''

        ''
          $mod,slash,exec,killall rofi || rofi -show combi -modes combi -combi-modes "clients:${
            lib.getExe scripts.goto-client
          },drun" -no-show-mode -combi-display-format "{text}"''
        "$modSHIFT,slash,exec,${lib.getExe scripts.get-client}"
      ];
    };
  };

}
