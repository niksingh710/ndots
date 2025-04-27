{
  inputs,
  pkgs,
  self,
  lib,
  ...
}:
with lib;
let
  utils = inputs.utils.packages.${pkgs.system};
  clients = pkgs.utils-clients;
  menus = pkgs.utils-menus;
  fullmenu = pkgs.fullmenu;
  spkgs = self.packages.${pkgs.system};
in
{
  wayland.windowManager.hyprland = {
    extraConfig = # hyprlang
      ''
        $submapreset = hyprctl dispatch submap reset
        bind = ALT,SPACE,submap,HLeader
        submap = HLeader # denotes HyprLeader
        bind = ,n,exec,$submapreset;killall rofi || uwsm app -- ${getExe' menus "network"}
        bind = ,b,exec,$submapreset;killall rofi || uwsm app -- ${getExe' menus "bluetooth"}
        bind = ,period,exec,$submapreset;killall rofi || uwsm app -- ${getExe' menus "rofimoji"}

        bind = ,a,exec,$submapreset;uwsm app -- ${getExe' menus "audio-sink"}
        bind = SHIFT,a,exec,$submapreset;uwsm app -- ${getExe fullmenu}
        bind = ,m,exec,$submapreset;uwsm app -- ${getExe' menus "audio-source"}

        bind = ,p,exec,$submapreset;${getExe pkgs.playerctl} play-pause
        bind = ,s,exec,$submapreset;${getExe spkgs.wl-ocr}
        bind = SHIFT,N,exec,$submapreset;${getExe' pkgs.mako "makoctl"} dismiss -a

        bind = ,escape,exec,hyprctl dispatch submap reset; killall rofi
        bind = ALT,SPACE,exec,hyprctl dispatch submap reset; killall rofi
        bind = $mod,SPACE,exec,hyprctl dispatch submap reset; killall rofi

        submap = reset
      '';
    settings = {
      "$cmd" = "killall rofi || uwsm app -- ";
      "$submapreset" = "hyprctl dispatch submap reset";
      bind = [
        "$modSHIFT,E,exec,$cmd ${getExe utils.powermenu-rofi}"
        "$mod,period,exec,$cmd ${getExe' menus "rofimoji"}"
        "$mod,slash,exec,$cmd ${getExe' clients "run-focus"}"
        "$modSHIFT,slash,exec,${getExe' clients "get-client"}"
      ];
    };
  };
}
