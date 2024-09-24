{ config, pkgs, ... }:
let
  inherit (config.lib.stylix) colors;

  colorsRasi = # css
    ''
      /*-*- mode: css; -*-*/
        color0:   #${colors.base00};
        color1:   #${colors.base01};
        color2:   #${colors.base02};
        color3:   #${colors.base03};
        color4:   #${colors.base04};
        color5:   #${colors.base05};
        color6:   #${colors.base06};
        color7:   #${colors.base07};
        color8:   #${colors.base08};
        color9:   #${colors.base09};
        color10:  #${colors.base0A};
        color11:  #${colors.base0B};
        color12:  #${colors.base0C};
        color13:  #${colors.base0D};
        color14:  #${colors.base0E};
        color15:  #${colors.base0F};
        active:   #${colors.base0F};
        inactive: #${colors.base03};
        selected: #${colors.base0F};

        background:           @color0;
        foreground:           @color15;

        background-color:     @background;
        border-color:         @background;
        separatorcolor:       @color8;
        scrollbar-handle:     @color9;

        normal-background:            @background;
        normal-foreground:            @foreground;
        alternate-normal-background:  @background;
        alternate-normal-foreground:  @foreground;
        selected-normal-background:   @active;
        selected-normal-foreground:   @foreground;

        active-background:            @inactive;
        active-foreground:            @foreground;
        alternate-active-background:  @active;
        alternate-active-foreground:  @foreground;
        selected-active-background:   @active;
        selected-active-foreground:   @foreground;

        urgent-background:            @color8;
        urgent-foreground:            @color15;
        alternate-urgent-background:  @color8;
        alternate-urgent-foreground:  @color15;
        selected-urgent-background:   @color14;
        selected-urgent-foreground:   @foreground;

        /* theme-based-custom */ 

        al:   #${colors.base00}00;
        bg:   #${colors.base00}88;
        bga:  #${colors.base00}AA;
        fg:   #${colors.base06}FF;
        ac:   #${colors.base01};
        se:   #${colors.base0D}66;
        dbg:  #${colors.base00}02;
        abg:  #${colors.base00}02;
    '';
  themes = {
    grid = # rasi
      ''
         @import "config"
         @theme "/dev/null"
         * {
           background-color: transparent;
           radius: 8px;
           roundness:                   15px;
         }

         inputbar {
           children: [entry];
         }

         entry {
           padding: 12px;
           vertical-align: 0.5;
           horizontal-align: 0.5;
           text-color: #${colors.base0F};
         }

         mainbox {
           children: [inputbar, listview];
        }
        window {
           /* properties for window widget */
           border-radius:               8px;

           /* properties for all widgets */
           enabled:                     true;
           cursor:                      "default";
           border-color:                @active;
           border:                      1px solid;
         }

         configuration {
           show-icons: false;
           me-select-entry: "";
           me-accept-entry: "MousePrimary";
           show-icons: true;
         }

         textbox {
           vertical-align:   0.5;
           horizontal-align: 0.5;
         }

         listview {
           columns:       9;
           lines:         7;
           cycle:         true;
           dynamic:       true;
           layout:        vertical;
           flow:          horizontal;
           reverse:       false;
           fixed-height:  true;
           fixed-columns: true;
         }

         element {
           orientation: vertical;
           enabled:                     true;
           spacing:                     10px;
           padding:                     -10px 0px 20px 0px;
           border-radius:               30px;
           background-color:            transparent;
           text-color:                  #${colors.base0F};
           cursor:                      pointer;
         }

         element selected.normal {
           background-color:            #${colors.base0E}77;
           text-color:                  #${colors.base0F};
         }

         element-icon {
           padding:                     0px;
           margin: 0px;
           background-color:            transparent;
           text-color:                  inherit;
           size:                        32px;
           cursor:                      inherit;
         }

         element-text {
           enabled: true;
           padding: 0px;
           margin: 0px;
           background-color:            transparent;
           text-color:                  inherit;
           cursor:                      inherit;
           vertical-align:              0;
           horizontal-align:            0.5;

           font:            "${config.stylix.fonts.emoji.name} 24";
         }

      '';
    custom = # rasi
      ''
        /*****----- Configuration -----*****/
        configuration {
          show-icons:                 true;
          drun-display-format:        "{name}";
          window-format:              "{w} · {c} · {t}";
          icon-theme:                 "flattrcolor-dark";
        }

        /*****----- Global Properties -----*****/
        * {
          ${colorsRasi}
          background:                  @bg;
          background-alt:              @bga;
          foreground:                  @fg;
          selected:                    @se;
          active:                      @ac;
          urgent:                      @dbg;
          roundness:                   15px;
          radius:                      15px;
          text-color: #${colors.base0F};
        }

        /*****----- Main Window -----*****/
        window {
          /* properties for window widget */
          location:                    east;
          anchor:                      east;
          fullscreen:                  false;
          width:                       30%;
          border-radius:               8px;
          height:                      99%;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          cursor:                      "default";
          background-color:            @background;
          border-color:                @active;
          border:                      1px solid;
        }

        /*****----- Main Box -----*****/
        mainbox {
          enabled:                     true;
          spacing:                     0px;
          background-color:            transparent;
          orientation:                 vertical;
          children:                    [ "inputbar", "listbox" ];
        }

        listbox {
          spacing:                     0px;
          padding:                     0px;
          background-color:            transparent;
          orientation:                 vertical;
          children:                    [ "message", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
          enabled:                     true;
          spacing:                     10px;
          padding:                     80px 60px;
          background-color:            transparent;
          background-image:            url("${config.stylix.image}", width);
          text-color:                  @foreground;
          orientation:                 horizontal;
          children:                    [ "textbox-prompt-colon", "entry" ];
        }
        textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "";
          padding:                     12px 15px;
          border-radius:               @radius;
          background-color:            @background-alt;
          text-color:                  inherit;
        }
        entry {
          enabled:                     true;
          expand:                      false;
          width:                       430px;
          padding:                     12px 16px;
          border-radius:               @radius;
          background-color:            @background-alt;
          text-color:                  inherit;
          cursor:                      text;
          placeholder:                 "Search";
          placeholder-color:           inherit;
        }
        dummy {
          expand:                      true;
          background-color:            transparent;
        }

        /*****----- Mode Switcher -----*****/
        mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          background-color:            transparent;
          text-color:                  @foreground;
        }
        button {
          width:                       45px;
          padding:                     12px;
          border-radius:               @radius;
          background-color:            @background-alt;
          text-color:                  inherit;
          cursor:                      pointer;
        }
        button selected {
          background-color:            @selected;
          text-color:                  @foreground;
        }

        /*****----- Listview -----*****/
        listview {
          enabled:                     true;
          columns:                     1;
          lines:                       6;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-columns:               true;
          fixed-height:                false;
          spacing:                     10px;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
          enabled:                     true;
          spacing:                     10px;
          padding:                     4px;
          border-radius:               @radius;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      pointer;
        }
        element normal.normal {
          background-color:            inherit;
          text-color:                  inherit;
        }
        element normal.urgent {
          background-color:            @urgent;
          text-color:                  @foreground;
        }
        element normal.active {
          background-color:            @active;
          text-color:                  @foreground;
        }
        element selected.normal {
          background-color:            @se;
          text-color:                  @background;
        }
        element selected.urgent {
          background-color:            @urgent;
          text-color:                  @foreground;
        }
        element selected.active {
          background-color:            @urgent;
          text-color:                  @foreground;
        }
        element-icon {
          padding:                     2px 0 2px 0;
          background-color:            transparent;
          text-color:                  inherit;
          size:                        32px;
          cursor:                      inherit;
        }
        element-text {
          background-color:            transparent;
          text-color:                  inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
        }

        /*****----- Message -----*****/
        message {
          background-color:            transparent;
        }
        textbox {
          padding:                     12px;
          border-radius:               @radius;
          background-color:            @background-alt;
          text-color:                  @foreground;
          vertical-align:              0.5;
          horizontal-align:            0.5;
        }
        error-message {
          padding:                     12px;
          border-radius:               20px;
          background-color:            @background;
          text-color:                  @foreground;
        }
      '';
  };
in
{
  home.file = {
    ".config/rofi/themes/grid.rasi".text = themes.grid;
    ".config/rofi/themes/custom.rasi".text = themes.custom;
    ".config/rofi/powermenu-conf.rasi".text = # rasi
      ''
        @import "./config.rasi"
        @theme "powermenu.rasi"

        configuration {
          kb-select-1: "l";
          kb-select-2: "s";
          kb-select-3: "e";
          kb-select-4: "r";
          kb-select-5: "S";
        }
      '';
    ".config/rofi/themes/powermenu.rasi".text = # rasi
      ''
        /*****----- Configuration -----*****/
        configuration {
            show-icons:                 false;
        }

        /*****----- Global Properties -----*****/
        * {
            /* Resolution : 1920x1080 */
            mainbox-spacing:             100px;
            mainbox-margin:              100px 12%;
            message-margin:              0px 400px;
            message-padding:             15px;
            message-border-radius:       100%;
            listview-spacing:            50px;
            element-padding:             55px 60px;
            element-border-radius:       100%;

            prompt-font:                 "MonoLisa Nerd Font Italic 64";
            textbox-font:                "MonoLisa Nerd Font Mono 16";
            element-text-font:           "feather 64";

            background-window:           black/5%;
            background-normal:           white/5%;
            background-selected:         white/15%;
            foreground-normal:           white;
            foreground-selected:         white;
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  true;
            cursor:                      "default";
            background-color:            @background-window;
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     @mainbox-spacing;
            margin:                      @mainbox-margin;
            background-color:            transparent;
            children:                    [ "dummy", "inputbar", "listview", "message", "dummy" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            background-color:            transparent;
            children:                    [ "dummy", "prompt", "dummy"];
        }

        dummy {
            background-color:            transparent;
        }

        prompt {
            enabled:                     true;
            font:                        @prompt-font;
            background-color:            transparent;
            text-color:                  @foreground-normal;
        }

        /*****----- Message -----*****/
        message {
            enabled:                     true;
            margin:                      @message-margin;
            padding:                     @message-padding;
            border-radius:               @message-border-radius;
            background-color:            @background-normal;
            text-color:                  @foreground-normal;
        }
        textbox {
            font:                        @textbox-font;
            background-color:            transparent;
            text-color:                  inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            expand:                      false;
            columns:                     5;
            lines:                       1;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
            
            spacing:                     @listview-spacing;
            background-color:            transparent;
            cursor:                      "default";
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            padding:                     @element-padding;
            border-radius:               @element-border-radius;
            background-color:            @background-normal;
            text-color:                  @foreground-normal;
            cursor:                      pointer;
        }
        element-text {
            font:                        @element-text-font;
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }
        element selected.normal {
            background-color:            @background-selected;
            text-color:                  @foreground-selected;
        }
      '';
    ".config/rofi/themes/colors.rasi".text = # rasi
      ''
        * {
          ${colorsRasi}
          }
      '';
    ".config/rofi/menu-conf.rasi".text = # rasi
      ''
        @import "./config.rasi"
        @theme "/dev/null"
        @import "./themes/colors.rasi"


        configuration {
          modi: "drun";
          display-drun: "";
          drun-display-format: "{name}";
        }

        * {
          al: @inactive;
          background-color: @bg;
          text-color: @fg;
        }

        window {
          location: south west;
          width: 265;
          x-offset: 60;
          y-offset: -10;
          height: 70%;
          spacing: 0;
          children: [ box ];
          border-radius: @radius;
        }

        box {
          padding: 0.5em;
          children: [ entry, listview ];
        }

        entry {
          placeholder: "Search...";
          padding: 0.5em;
          expand: false;
        }

        element {
          text-color: @al;
          padding: 0em;
        }
        element selected {
          text-color: @background;
          background-color: @se;
        }
        element selected.normal {
          text-color: @background;
          background-color: @se;
        }

        element-text, element-icon {
          background-color: inherit;
          text-color: inherit;
        }

        listview, element, element selected, element-text, element-icon {
          cursor: pointer;
        }    
      '';
    ".config/rofi/themes/network.rasi".text = # rasi
      ''
        @import "./config.rasi"

        @theme "/dev/null"
        @import "../themes/colors.rasi"
        @import "../menu-conf.rasi"

        window {
          location: south east;
          width: 30%;
          x-offset: 0%;
          y-offset: 0;
          height: 60%;
          border-radius: 8px;
          background-color: transparent;
        }

        listview, element, element selected, element-text, element-icon {
          padding: 4px;
          background-color: transparent;
        }
      '';
    ".config/rofi/themes/bluetooth.rasi".text = # rasi
      ''
        @import "./config.rasi"

        @theme "/dev/null"
        @import "../themes/colors.rasi"
        @import "../menu-conf.rasi"

        window {
          location: south east;
          width: 30%;
          x-offset: 0%;
          y-offset: 0;
          height: 40%;
          background-color: transparent;
          border-radius: 8px;
        }

        listview, element, element selected, element-text, element-icon {
          padding: 4px;
          background-color: transparent;
        }
      '';
    ".config/rofi/themes/menu-full.rasi".text = # rasi
      ''
        @import "colors.rasi"
        /*****----- Configuration -----*****/
        configuration {
        	modi:                       "drun";
            show-icons:                 true;
            display-drun:               "🔍";
        	drun-display-format:        "{name}";
        }

        /*****----- Main Window -----*****/
        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  true;
            width:                       1366px;
            height:                      768px;
            x-offset:                    0px;
            y-offset:                    0px;

            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            black / 10%;
            cursor:                      "default";
        }

        /*****----- Main Box -----*****/
        mainbox {
            enabled:                     true;
            spacing:                     100px;
            margin:                      0px;
            padding:                     100px 225px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @selected;
            background-color:            transparent;
            children:                    [ "inputbar", "listview" ];
        }

        /*****----- Inputbar -----*****/
        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0% 28%;
            padding:                     10px;
            border:                      1px solid;
            border-radius:               6px;
            border-color:                white / 25%;
            background-color:            white / 5%;
            text-color:                  @foreground;
            children:                    [ "prompt", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            transparent;
            text-color:                  inherit;
        }
        textbox-prompt-colon {
            enabled:                     true;
            expand:                      false;
            str:                         "::";
            background-color:            transparent;
            text-color:                  inherit;
        }
        entry {
            enabled:                     true;
            background-color:            transparent;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search";
            placeholder-color:           inherit;
        }

        /*****----- Listview -----*****/
        listview {
            enabled:                     true;
            columns:                     7;
            lines:                       4;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
            
            spacing:                     0px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @selected;
            border-radius:               0px;
            background-color:            @background-alt;
        }

        /*****----- Elements -----*****/
        element {
            enabled:                     true;
            spacing:                     15px;
            margin:                      0px;
            padding:                     10px;
            border:                      0px solid;
            border-radius:               15px;
            border-color:                @selected;
            background-color:            transparent;
            text-color:                  @foreground;
            orientation:                 vertical;
            cursor:                      pointer;
        }
        element normal.normal {
            background-color:            transparent;
            text-color:                  @foreground;
        }
        element selected.normal {
            background-color:            white / 5%;
            text-color:                  @foreground;
        }
        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        72px;
            cursor:                      inherit;
        }
        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.5;
        }

        /*****----- Message -----*****/
        error-message {
            padding:                     100px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @selected;
            background-color:            black / 10%;
            text-color:                  @foreground;
        }
        textbox {
            background-color:            transparent;
            text-color:                  @foreground;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
        }
      '';
    ".config/rofi/themes/audio-channel.rasi".text = # rasi
      ''
        @import "./config.rasi"

        @theme "/dev/null"
        @import "../themes/colors.rasi"
        @import "../menu-conf.rasi"

        window {
          location: south east;
          width: 12%;
          x-offset: 0%;
          y-offset: -13%;
          height: 14em;
          background-color: transparent;
          border-radius: 8px;
        }

        listview, element, element selected, element-text, element-icon {
          padding: 4px 0px;
          background-color: transparent;
        }
      '';
    ".config/rofimoji.rc".text = # rc
      ''
        action = [copy, type]
        files = [emoticons, emojis, kaomoji, nerd]
        skin-tone = moderate
        max-recent = 5
        selector = rofi
        clipboarder = wl-copy
        typer = wtype
      '';
  };
  stylix.targets.rofi.enable = false;
  programs.rofi = {
    package = pkgs.rofi-wayland;
    # plugins = [ pkgs.rofi-calc ];
    enable = true;
    theme = "./custom.rasi";
    extraConfig = {
      show-icons = true;
      drun-display-format = "{name}";
      hide-scrollbar = true;
      sidebar-mode = false;
      kb-remove-to-eol = "Control+p";
      kb-secondary-copy = "Control+c";
      kb-accept-entry = "Return";
      kb-mode-complete = "";
      kb-remove-char-back = "BackSpace";
      kb-row-up = "Up,Control+k";
      kb-row-down = "Down,Control+j";
      kb-row-right = "Control+l";
      kb-row-left = "Control+h";
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = [ "MousePrimary" "MouseSecondary" ];
      terminal = "foot";
      font = "${config.stylix.fonts.monospace.name} 12";
    };
  };
}
