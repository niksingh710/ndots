{ pkgs, ... }:
{
  home.packages = with pkgs;[ clipse ];
  home.file.".config/clipse/config.json".text = # json
    ''
      {
        "historyFile": "clipboard_history.json",
        "maxHistory": 1000,
        "allowDuplicates": false,
        "themeFile": "custom_theme.json",
        "tempDir": "tmp_files",
        "logFile": "clipse.log",
        "keyBindings": {
          "choose": "enter",
          "clearSelected": "D",
          "down": "j",
          "end": "G",
          "filter": "/",
          "home": "home",
          "more": "?",
          "nextPage": ">",
          "prevPage": "<",
          "preview": "P",
          "quit": "q",
          "remove": "d",
          "selectDown": "ctrl+down",
          "selectSingle": "enter",
          "selectUp": "ctrl+up",
          "togglePin": "p",
          "togglePinned": "tab",
          "up": "k",
          "yankFilter": "y"
         },
        "imageDisplay": {
          "type": "sixel",
          "scaleX": 16,
          "scaleY": 18,
          "heightCut": 2
         }
      }
    '';

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm app -- clipse -listen"
    ];
    bind = [
      "$mod,v,exec,uwsm app -- foot -a 'clipse' sh -c 'clipse'"
      "$modSHIFT,v,exec,uwsm app -- clipse -clear"
    ];
    windowrulev2 = [
      "float, class:^(clipse)$"
      "stayfocused, class:^(clipse)$"
      # "move cursor 0 0, class:^(clipse)$"
      "center, class:^(clipse)$"
      "pin, class:^(clipse)$"
      "opacity 1, class:^(clipse)$"
      "noanim 1, class:^(clipse)$"
      "noanim 1, class:^(clipse)$"
      "immediate on, class:^(clipse)$"
      "suppressevent fullscreen maximize, class:^(clipse)$"
    ];
  };
}
