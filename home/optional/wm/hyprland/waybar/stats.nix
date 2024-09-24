{ pkgs, lib, ... }: {
  programs.waybar.settings.mainBar = {
    modules-left = [ "group/info" ];

    "group/info" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [ "custom/dmark" "group/gcpu" "memory" "disk" ];
    };
    "custom/dmark" = {
      format = "";
      tooltip = false;
    };
    "group/gcpu" = {
      orientation = "inherit";
      modules = [ "custom/cpu-icon" "custom/cputemp" "cpu" ];
    };
    "custom/cpu-icon" = {
      format = "󰻠";
      tooltip = false;
    };
    "custom/cputemp" = {
      format = "{}";
      exec = pkgs.writeShellScript "cputemp" ''

        data="$(${
          lib.getExe' pkgs.lm_sensors "sensors"
        } coretemp-isa-0000 | sed 's/+//g')"
        package="$(echo "$data" | awk -e '/Package/ {print $4}')"
        coretemp="$(echo "$data" | awk -e '/Core/ {print $3}')"

        tooltip="<b>Core Temp: $package </b>\n"

        # "format-icons" : [ "", "", "", "", "" ] ,
        tempint=''${package%.*}
        temp="<b>''${tempint}󰔄</b>"
        icon=""
        class="cool"
        [ "$tempint" -gt 50 ] && {
          icon=""
          class="normal"
        }
        [ "$tempint" -gt 70 ] && {
          icon=" "
          class="warm"
        }
        [ "$tempint" -gt 85 ] && {
          icon=" " class="warn"
        }
        [ "$tempint" -gt 95 ] && {
          icon=" "
          class="critical"
        }

        j=0
        for i in $coretemp; do
          tooltip+="Core $j: $i\n"
          ((j = j + 1))
        done
        tooltip="''${tooltip::-2}"
        cat <<EOF
        {"text":"$temp","tooltip":"$tooltip", "class": "$class"}
        EOF
      '';
      interval = 10;
      return-type = "json";
    };
    cpu = {
      format = "<b>{usage}</b>%";
      on-click = "foot btop";
    };
    memory = {
      on-click = "foot btop";
      format = ''
        <b>   
        {}</b>%'';
    };
    disk = {
      on-click = "foot btop";
      interval = 600;
      format = ''
        <b> 󰋊 
         {percentage_used}</b>%'';
      path = "/";
    };
  };
}
