{ pkgs, lib, ... }: {
  programs.waybar.settings.mainBar = {
    modules-right = [ "group/together" "tray" ];
    "group/together" = {
      orientation = "inherit";
      modules = [ "group/utils" "clock" ];
    };
    "group/utils" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
      };
      modules = [
        "custom/mark"
        "custom/weather"
        "custom/colorpicker"
        # "custom/hyprshade"
        "idle_inhibitor"
        "custom/hyprkill"
      ];
    };
    tray = {
      icon-size = 18;
      spacing = 10;
    };
    "custom/hyprkill" = {
      format = "{}";
      interval = "once";
      exec = ''
        echo "󰅙
        Kill clients using hyrpctl kill"'';
      on-click = "sleep 1 && hyprctl kill";
    };
    "custom/colorpicker" = let
      colorpicker = pkgs.writeShellApplication {
        name = "colorpicker";
        bashOptions = [ "pipefail" ];
        runtimeInputs = with pkgs; [ hyprpicker wl-clipboard ];
        text = ''
          loc="$HOME/.cache/colorpicker"
          [ -d "$loc" ] || mkdir -p "$loc"
          [ -f "$loc/colors" ] || touch "$loc/colors"

          limit=10

          [[ $# -eq 1 && $1 = "-l" ]] && {
            cat "$loc/colors"
            exit
          }

          [[ $# -eq 1 && $1 = "-j" ]] && {
            text="$(head -n 1 "$loc/colors")"

            mapfile -t allcolors < <(tail -n +2 "$loc/colors")
            # allcolors=($(tail -n +2 "$loc/colors"))
            tooltip="<b>   COLORS</b>\n\n"

            tooltip+="<b>$text</b>  <span color='$text'></span>  \n"
            for i in "''${allcolors[@]}"; do
              tooltip+="<b>$i</b>  <span color='$i'></span>  \n"
            done

            cat <<EOF
          { "text":"<span color='$text'></span>", "tooltip":"$tooltip"}  
          EOF

            exit
          }

          killall -q hyprpicker
          color=$(hyprpicker)
          echo "$color" | sed -z 's/\n//g' | wl-copy

          prevColors=$(head -n $((limit - 1)) "$loc/colors")
          echo "$color" >"$loc/colors"
          echo "$prevColors" >>"$loc/colors"
          sed -i '/^$/d' "$loc/colors"
          pkill -RTMIN+1 waybar
        '';
      };
    in {
      format = "{}";
      return-type = "json";
      interval = "once";
      exec = "${lib.getExe colorpicker} -j";
      on-click = "sleep 1 && ${lib.getExe colorpicker}";
      signal = 1;
    };
    "custom/weather" = {
      format = "{}";
      tooltip = true;
      interval = 3600;
      exec = ''
        ${lib.getExe pkgs.wttrbar} --custom-indicator '{ICON}
        <b>{temp_C}</b>' --location noida'';
      return-type = "json";
    };
    "custom/mark" = {
      format = "";
      tooltip = false;
    };
    clock = {
      format = ''
        {:%H
        %M}'';
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = { today = "<span color='#a6e3a1'><b><u>{}</u></b></span>"; };
      };
    };
    idle_inhibitor = {
      format = "{icon}";
      tooltip-format-activated = "Idle Inhibitor is active";
      tooltip-format-deactivated = "Idle Inhibitor is not active";
      format-icons = {
        activated = "󰔡";
        deactivated = "󰔢";
      };
    };
  };
}
