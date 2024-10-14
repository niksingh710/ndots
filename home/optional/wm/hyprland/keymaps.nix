{ pkgs, lib, inputs, config, ... }:
let
  scripts = {
    img-annotate = pkgs.writeShellScript "img-annotate" ''
      ${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${
        lib.getExe pkgs.swappy
      } -f - &>/dev/null || {
        ${
          lib.getExe' pkgs.libnotify "notify-send"
        } "swappy failed" "Maybe clipboard is not having a image as input"
        exit 1
      }
    '';

    focus = pkgs.writeShellScript "focus" ''

      [ $# -eq 0 ] && {
        echo "invalid move"
      }

      [ "$1" = "cyclenext" ] && {
        arg="none"
        [ -z "$2" ] || arg="prev"
        hyprctl dispatch cyclenext "$arg"
        exit
      }
      if [[ "$1" =~ ^(l|r|u|d)$ ]]; then
        floating=$(hyprctl activewindow -j | ${lib.getExe pkgs.jq} '.floating')
        if [ "$floating" = true ]; then
          arg=none
          [[ "$1" =~ ^(l|u)$ ]] && arg='prev'
          hyprctl dispatch cyclenext "$arg"
          floating=$(hyprctl activewindow -j | ${
            lib.getExe pkgs.jq
          } '.floating')
          # Checks for if newly focused window is also floating
          if [ "$floating" = true ]; then
            pid=$(hyprctl activewindow -j | ${lib.getExe pkgs.jq} '.pid')
            hyprctl dispatch alterzorder top,"pid:$pid"
          fi
        else
          hyprctl dispatch movefocus "$1"
          pid=$(hyprctl activewindow -j | ${lib.getExe pkgs.jq} '.pid')
          hyprctl dispatch alterzorder top,"pid:$pid"
        fi
      fi 
    '';

    move = pkgs.writeShellScript "move" ''

      _curr_win_state=$(hyprctl activewindow -j | ${
        lib.getExe pkgs.jq
      } -r '.floating')
      val=15

      getVal() {
        case "$1" in
        "r")
          echo "$val 0"
          ;;
        "d")
          echo "0 $val"
          ;;
        "l")
          echo "-$val 0"
          ;;
        "u")
          echo "0 -$val"
          ;;
        esac
      }

      if [ $# -eq 0 ]; then
        echo "No arguments provided"
        exit 1
      fi

      if [[ $_curr_win_state == "true" ]]; then
        # shellcheck disable=SC2046
        hyprctl dispatch moveactive $(getVal "$1")
      else
        hyprctl dispatch movewindow "$1"
      fi
    '';
    camera-toggle = pkgs.writeShellScript "camera-toggle" ''

      state="$(lsmod | grep uvcvideo)"

      [ -z "$state" ] && {
        notify-send "Enabling camera module: uncvideo" "If fails to work check root permissions"
        sudo modprobe -a uvcvideo
      } || {
        notify-send "Disabling camera module: uncvideo" "If fails to work check root permissions"
        sudo rmmod -f uvcvideo
      }

      # refreshes waybar module
      pkill -RTMIN+3 waybar
    '';
    zoom = pkgs.writeShellScript "zoom" # bash
      ''

        check() {
          command -v "$1" >/dev/null 2>&1
        }

        notify() {
          check notify-send && notify-send "Zoom" "$1" || echo "$1"
        }
        current_zoom_size() {
          hyprctl getoption cursor:zoom_factor -j | ${
            lib.getExe pkgs.jq
          } '.float'
        }

        # Args handler
        getargs() {
          # shellcheck disable=SC2015
          if [ -n "$1" ]; then
            zoom_curr=$(current_zoom_size)
            # TODO: fix this
            zoom_value="$(echo "$zoom_curr" + "$1" | ${
              lib.getExe' pkgs.bc "bc"
            })"
            hyprctl keyword cursor:zoom_factor "$zoom_value"
          else
            hyprctl keyword cursor:zoom_factor "1.0"
          fi
        }
        getargs "$@"
        # vim: ft=sh
      '';
    fullscreen = pkgs.writeShellScript "fullscreen" # bash
      ''
        fullscreenmode="$(hyprctl activewindow -j | ${
          lib.getExe pkgs.jq
        } '.fullscreenClient')"

        result=$(( (fullscreenmode + 1) % 3 ))
        hyprctl dispatch fullscreen "$result"
      '';

    toggle-group = pkgs.writeShellScript "toggle-group" ''
      isGroup="$(hyprctl activewindow -j | ${
        lib.getExe pkgs.jq
      } '.grouped | length')"

      [ "$isGroup" -eq "0" ] && {
      	hyprctl dispatch togglegroup
      	notify "Group enabled"
      } || {
      	hyprctl dispatch submap "Group"
      	notify "Entered Submap"
      }
    '';
    lib-down = pkgs.writeShellScript "lid-down" ''
      mon_count=$(hyprctl monitors -j | ${lib.getExe pkgs.jq} '. | length')

      if [ "$mon_count" -eq 1 ]; then
        state=$(awk '{print $2}' </proc/acpi/button/lid/LID*/state)
        sleep 3
        [ "$state" = "open" ] || {
          systemctl suspend
        }
      else
        sleep 1
        hyprctl keyword monitor "eDP-1, disable"
      fi
    '';
  };

  applications = {
    volume = pkgs.writeShellApplication {
      name = "volume";
      runtimeInputs = with pkgs; [ pulseaudio libnotify ];
      text = ''

        MOD="1%" # volume increment steps

        notify() {
          notify-send -a "Volume" "$@" || echo "$@"
        }

        [[ "$(pactl get-sink-mute @DEFAULT_SINK@)" == *"no"* ]] && mute=false || mute=true

        toggleMute() {
          pactl set-sink-mute @DEFAULT_SINK@ toggle
          $mute && mute=false || mute=true
        }

        getVolume() {
          pactl get-sink-volume @DEFAULT_SINK@ | grep -o '\w\+%' | head -n1 | sed 's/%//g'
        }

        send_notification() {
          $mute && {
            notify "Muted"
            return
          }
          volume="$(getVolume)%"

          notify \
            --hint=string:x-dunst-stack-tag:volume \
            --hint=string:synchronous:volume \
            -a "Volume" -u low \
            -h int:value:"$volume" "Volume: ''${volume}" \
            -t 1000
        }

        case $1 in
        up)
          $mute && toggleMute
          [ $(($(getVolume))) -gt 145 ] && {
            send_notification
            exit
          }
          pactl set-sink-volume @DEFAULT_SINK@ +''${MOD}
          send_notification
          ;;
        down)
          $mute && toggleMute
          pactl set-sink-volume @DEFAULT_SINK@ -''${MOD}
          send_notification
          ;;
        mute)
          toggleMute
          send_notification
          ;;
        esac
      '';
    };
    brightness = pkgs.writeShellApplication {
      name = "brightness";
      runtimeInputs = with pkgs; [ libnotify brightnessctl ];
      text = ''
        notify() {
          # shellcheck disable=SC2015
          notify-send "$@" || echo "$@"
        }

        send_notification() {
          brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))
          brightness=''${brightness%.*}
          notify \
            --hint=string:x-dunst-stack-tag:brightness \
            --hint=string:synchronous:brightness \
            -a "Brightness" \
            -h int:value:"$brightness" \
            "Brightness: ''${brightness}%"
        }

        case $1 in
        up)
          brightnessctl s +5%
          send_notification
          ;;
        down)
          brightnessctl s 5%-
          send_notification
          ;;
        esac
      '';
    };

    quick-term = pkgs.writeShellApplication {
      name = "quick-term";
      runtimeInputs = with pkgs; [ jq foot ];
      bashOptions = [ "pipefail" ];
      text = ''
        # shellcheck disable=SC2009
        _pid="$(ps -fu | grep "foot-quick" | grep -v "grep" | awk '{print $2}')"

        if [ -n "$_pid" ]; then
          curr_focused="$(hyprctl activewindow -j | jq -r '.class')"
          if [ "$curr_focused" = "foot-quick" ]; then
            kill -9 "$_pid"
          else
            hyprctl dispatch focuswindow pid:"$_pid"
          fi
        else
          foot -a "foot-quick" sh -c "tmux new-session -A -s 'quick-term'" >/dev/null 2>&1 &
          exit 0
        fi
      '';
    };
  };
  workspace = [
    "$mod,mouse_up,workspace,e+1"
    "$mod,mouse_down,workspace,e-1"

    "$mod,1,workspace,1"
    "$mod,2,workspace,2"
    "$mod,3,workspace,3"
    "$mod,4,workspace,4"
    "$mod,5,workspace,5"
    "$mod,6,workspace,6"
    "$mod,7,workspace,7"
    "$mod,8,workspace,8"
    "$mod,9,workspace,9"
    "$mod,0,workspace,10"

    "$modSHIFT,1,movetoworkspace,1"
    "$modSHIFT,2,movetoworkspace,2"
    "$modSHIFT,3,movetoworkspace,3"
    "$modSHIFT,4,movetoworkspace,4"
    "$modSHIFT,5,movetoworkspace,5"
    "$modSHIFT,6,movetoworkspace,6"
    "$modSHIFT,7,movetoworkspace,7"
    "$modSHIFT,8,movetoworkspace,8"
    "$modSHIFT,9,movetoworkspace,9"
    "$modSHIFT,0,movetoworkspace,10"

    "$mod,p,workspace,e-1"
    "$mod,n,workspace,e+1"

    "$modSHIFT,p,movetoworkspace,-1"
    "$modSHIFT,n,movetoworkspace,+1"
  ];

  contrib = inputs.hyprland-contrib.packages.${pkgs.system};
in {
  home.packages = (with contrib; [ grimblast scratchpad ])
    ++ (with applications; [ volume brightness ]);

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig.XDG_SS_DIR =
        "${config.home.homeDirectory}/Pictures/Screenshots";
    };
  };

  wayland.windowManager.hyprland = {
    settings = {

      "$notify" = "notify-send -a 'Hyprland'";
      "$tpadcmd" = "hyprctl keywords device:elan-touchpad";
      "$tpadon" = "$tpadcmd:enabled true; $tpadcmd:natural_scroll true";
      "$tpadoff" = "$tpadcmd:enabled false";

      "$sspath" =
        ''~/Pictures/Screenshots/"$(date +"ss-%d-%b-%C_%H-%M-%S")".png'';
      "$sscommand" = "grimblast -f --notify --cursor copysave";
      "$ssarea" = ''
        hyprctl keyword animation "fadeOut,1,4,default"; $sscommand area $sspath; hyprctl keyword animation "fadeOut,1,4,default"'';

      input = {
        # maps the capslock key to control
        kb_options = "ctrl:nocaps";
      };

      bind = workspace ++ [
        "$mod,Return,exec,foot"
        ''$modSHIFT,RETURN,exec,foot sh -c "tmux new-session -A -s main"''
        "$mod,q,killactive"
        "$mod,s,togglesplit"

        '',XF86TouchpadOn,exec,$tpadon && $notify "Touchpad: On"''
        '',XF86TouchpadOff,exec,$tpadoff && $notify "Touchpad: Off"''

        # Movement of windows (focus, move, resize)
        "$mod,h,exec,${scripts.focus} l"
        "$mod,l,exec,${scripts.focus} r"
        "$mod,k,exec,${scripts.focus} u"
        "$mod,j,exec,${scripts.focus} d"

        ",XF86PowerOff,exec,systemctl suspend"
        ",XF86WebCam,exec,${scripts.camera-toggle}"

        ",XF86AudioMicMute,exec,${
          lib.getExe' pkgs.pulseaudio "pactl"
        } set-source-mute @DEFAULT_SOURCE@ toggle"

        ",XF86AudioMute,exec,${lib.getExe applications.volume} mute"

        "$modSHIFT,equal,exec,${scripts.zoom}"
        "$modSHIFT,minus,exec,${scripts.zoom}"

        "$mod,f,togglefloating,"
        "$mod,m,exec,${scripts.fullscreen}"
        "$modSHIFT,f,pseudo,"

        "$modSHIFT,x,exec,hyprctl kill"

        "$modSHIFT,a,pin,"
        "$modCTRLSHIFT,f,workspaceopt,allfloat"

        ''
          $modSHIFT,o,exec,hyprctl setprop active opaque toggle

        ''
        "$modSHIFT,c,centerwindow,"

        ",Scroll_Lock,exec,loginctl lock-session"
        ",F9,exec,loginctl lock-session"

        "$mod,r,exec,hyprctl reload"

        "SUPER,SPACE,exec,hyprctl dispatch focusmonitor +1"
        "SUPERSHIFT,SPACE,exec,hyprctl dispatch movewindow mon:+1"

        # scratchpad layout keymaps
        ''SUPER,comma,exec,scratchpad -n "rough"''
        ''SUPERSHIFT,comma,exec,scratchpad -n "rough" -g''

        ",Print,exec,$sscommand output $sspath"
        "SUPERSHIFT,Print,exec,$ssarea"
        "SUPER,Print,exec,$sscommand active $sspath"
        "ALT,Print,exec,$sscommand screen $sspath"
        "CTRL,grave,exec,${lib.getExe applications.quick-term}"
      ];
      bindm = [ "$mod,mouse:272,movewindow" "$mod,mouse:273,resizewindow 2" ];
      bindl = [
        ", switch:off:Lid Switch, exec, hyprctl reload"
        ", switch:on:Lid Switch, exec,${scripts.lib-down}"
      ];
      binde = [

        "$mod,e,exec,${scripts.img-annotate}"

        "$modCTRL,h,resizeactive,-50 0"
        "$modCTRL,l,resizeactive,50 0"
        "$modCTRL,j,resizeactive,0 50"
        "$modCTRL,k,resizeactive,0 -50"

        "$modSHIFT,h,exec,${scripts.move} l"
        "$modSHIFT,l,exec,${scripts.move} r"
        "$modSHIFT,j,exec,${scripts.move} d"
        "$modSHIFT,k,exec,${scripts.move} u"

        "bind = SUPER, c, togglespecialworkspace, comms"
        "bind = SUPERSHIFT, C, movetoworkspace, special:comms"

        ",XF86AudioRaiseVolume,exec,${lib.getExe applications.volume} up"
        ",XF86AudioLowerVolume,exec,${lib.getExe applications.volume} down"

        ",XF86MonBrightnessUp,exec,${lib.getExe applications.brightness} up"
        ",XF86MonBrightnessDown,exec,${lib.getExe applications.brightness} down"

        "$mod,equal,exec,${scripts.zoom} 0.1"
        "$mod,minus,exec,${scripts.zoom} -0.1"
      ];
    };
    extraConfig = # hyprlang
      ''
        bind = $modSHIFT,g,exec,${scripts.toggle-group}

        bind = ALT,h,changegroupactive,b
        bind = ALT,l,changegroupactive,f

        submap = Group
        bind = SHIFT,l,moveintogroup,r
        bind = SHIFT,h,moveintogroup,l
        bind = SHIFT,j,moveintogroup,d
        bind = SHIFT,k,moveintogroup,u

        # Movement of windows (focus, move, resize)
        bind = $mod,h,exec,${scripts.focus} l
        bind = $mod,l,exec,${scripts.focus} r
        bind = $mod,k,exec,${scripts.focus} u
        bind = $mod,j,exec,${scripts.focus} d

        bind = ,e,exec,hyprctl --batch "dispatch submap reset; dispatch togglegroup";$notify 'Exited Group'
        bind = ,q,submap,reset

        bind = ,escape,submap,reset
        bind = $mod,SPACE,submap,reset
        submap = reset

        # Passes the keymaps to windows disables global keymaps{{{
        bind = $mod,g,submap,Pass
        submap = Pass
        bind = ,,pass,^(.*)$
        bind = ,escape,submap,reset 
        bind = $mod,SPACE,submap,reset 
        submap = reset

      '';

  };

}
