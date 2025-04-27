{ inputs, pkgs, config, lib, ... }: with lib;
let
  inherit (config.lib.stylix) colors;
  contrib = inputs.hyprland-contrib.packages.${pkgs.system};
  utils = inputs.utils.packages.${pkgs.system};
  clients = utils.clients.override (with colors; {
    rofi-theme-str = # scss
      ''
        * {
            background: #${base00};
            background-alt: #${base03};
            selected: #${base02};
            foreground: #${base06};
          }
      '';
  });
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

    "$mod,SPACE,exec,hyprctl dispatch focusmonitor +1"
    "$modSHIFT,SPACE,exec,hyprctl dispatch movewindow mon:+1"

    ''$mod,comma,exec,scratchpad -n "rough"''
    ''$modSHIFT,comma,exec,${lib.getExe' clients "scratchpad-get"} -n "rough"''

    # Communication workspace comes and goes quickly
    "bind = $mod, c, togglespecialworkspace, comms"
    "bind = $modSHIFT, C, movetoworkspace, special:comms"

    "bind = $mod, apostrophe, togglespecialworkspace, quick"
    "bind = $modSHIFT, apostrophe, movetoworkspace, special:quick"
  ];

in
{

  home.packages = with contrib; [ grimblast scratchpad ]
    ++ (with utils; [ volume brightness ]);
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
        hyprctl keyword animation "fadeOut,1,4,default"; grimblast -f --notify copysave area $sspath; hyprctl keyword animation "fadeOut,1,4,default"'';

      # capslock will work as ctrl
      input.kb_options = "ctrl:nocaps";
      bind = workspace ++ [
        "$mod,q,killactive"
        "$mod,s,togglesplit"

        '',XF86TouchpadOn,exec,$tpadon && $notify "Touchpad: On"''
        '',XF86TouchpadOff,exec,$tpadoff && $notify "Touchpad: Off"''
        ",XF86PowerOff,exec,systemctl suspend" # ensure disable Hold power button

        # Movement of windows (focus, move, resize)
        "$mod,h,exec,${getExe utils.focus} l"
        "$mod,l,exec,${getExe utils.focus} r"
        "$mod,k,exec,${getExe utils.focus} u"
        "$mod,j,exec,${getExe utils.focus} d"

        ",XF86AudioMicMute,exec,${getExe utils.volume} mic-mute"
        ",XF86AudioMute,exec,${getExe utils.volume} mute"
        "SHIFT,XF86AudioMute,exec,${getExe utils.volume} mic-mute"

        "$modSHIFT,equal,exec,${getExe utils.zoom} reset"

        "$mod,f,togglefloating,"
        "$modSHIFT,f,pseudo,"
        "$mod,m,exec,${getExe utils.fullscreen}"

        "$modSHIFT,x,exec,hyprctl kill"

        "$modSHIFT,a,pin,"
        "$modCTRLSHIFT,f,workspaceopt,allfloat"

        "$modSHIFT,o,exec,hyprctl setprop active opaque toggle"
        "$modCTRL,c,centerwindow,"

        ",Scroll_Lock,exec,loginctl lock-session"
        ",F9,exec,loginctl lock-session"
        "$mod,r,exec,hyprctl reload"

        ",Print,exec,$sscommand output $sspath"
        "$modSHIFT,Print,exec,$ssarea"
        "$mod,Print,exec,$sscommand active $sspath"
        "ALT,Print,exec,$sscommand screen $sspath"
      ];
      bindm = [ "$mod,mouse:272,movewindow" "$mod,mouse:273,resizewindow 2" ];
      bindl = [
        ", switch:on:Lid Switch, exec,${getExe utils.lid-down}"
      ];
      binde = [
        "$mod,e,exec,${getExe utils.img-annotate}"

        "$modSHIFT,h,exec,${getExe utils.move} l"
        "$modSHIFT,l,exec,${getExe utils.move} r"
        "$modSHIFT,j,exec,${getExe utils.move} d"
        "$modSHIFT,k,exec,${getExe utils.move} u"

        "$modSHIFT,q,exec,${getExe utils.fast}"

        ",XF86AudioRaiseVolume,exec,${getExe utils.volume} up"
        ",XF86AudioLowerVolume,exec,${getExe utils.volume} down"

        ",XF86MonBrightnessUp,exec,${getExe utils.brightness} up"
        ",XF86MonBrightnessDown,exec,${getExe utils.brightness} down"

        "$mod,equal,exec,${getExe utils.zoom} in"
        "$mod,minus,exec,${getExe utils.zoom} out"

        "$modCTRL,h,resizeactive,-50 0"
        "$modCTRL,l,resizeactive,50 0"
        "$modCTRL,j,resizeactive,0 50"
        "$modCTRL,k,resizeactive,0 -50"
      ];
    };
    extraConfig = # hyprlang
      ''
        bind = $modSHIFT,g,exec,${getExe utils.toggle-group}

        bind = ALT,h,changegroupactive,b
        bind = ALT,l,changegroupactive,f

        submap = Group
        bind = SHIFT,l,moveintogroup,r
        bind = SHIFT,h,moveintogroup,l
        bind = SHIFT,j,moveintogroup,d
        bind = SHIFT,k,moveintogroup,u

        # Movement of windows (focus, move, resize)
        bind = $mod,h,exec,${getExe utils.focus} l
        bind = $mod,l,exec,${getExe utils.focus} r
        bind = $mod,k,exec,${getExe utils.focus} u
        bind = $mod,j,exec,${getExe utils.focus} d

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
