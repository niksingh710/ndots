{ pkgs, config, opts, ... }:
let inherit (config.lib.stylix) colors;
in {
  persist.dir = [ ".config/qt6ct" ".config/qt5ct" ".config/QtProject.conf" ];
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style = {
      name = "kvantum-dark";
      package = with pkgs; [ adwaita-qt adwaita-qt6 libsForQt5.qt5ct ];
    };
  };
  home = {
    packages = with pkgs; [ libsForQt5.qt5.qtwayland kdePackages.qtwayland ];
    file = {
      ".config/qt6ct/qt6ct.conf".text = ''
        [Appearance]
        color_scheme_path=/home/${opts.username}/.config/qt6ct/colors/stylix.conf
        custom_palette=true
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=gtk3
        style=Adwaita-dark

        [Fonts]
        fixed="${config.stylix.fonts.monospace.name},12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        general="${config.stylix.fonts.monospace.name},12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\x9c\0\0\x2\x11\0\0\0\0\0\0\0\0\0\0\x3\xa6\0\0\x2\x1b\0\0\0\x1\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x3\x9c\0\0\x2\x11)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
      ".config/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        color_scheme_path=/home/${opts.username}/.config/qt5ct/colors/stylix.conf
        custom_palette=true
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=gtk3
        style=Adwaita-dark

        [Fonts]
        fixed="${config.stylix.fonts.monospace.name},12,-1,5,50,0,0,0,0,0"
        general="${config.stylix.fonts.monospace.name},12,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\x9c\0\0\x4+\0\0\0\0\0\0\0\0\0\0\x3\xa6\0\0\x4\x37\0\0\0\x1\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x3\x9c\0\0\x4+)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
      ".config/qt6ct/colors/stylix.conf".text = ''
        #               FG              BTN_BG bright less brdark        less da     txt fg               br text              btn fg           txt bg     bg     shadow   sel bg     sel fg     link       visited           alt bg default          tooltip bg  tooltip_fg	placeholder_fg
        [ColorScheme]
        active_colors=#${colors.base0F},          #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base0F},           #${colors.base0F},           #${colors.base0F},           #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base0F},            #${colors.base00}, #${colors.base0F},           ${colors.base00},  #${colors.base0F}, #${colors.base06}
        disabled_colors=#${colors.base06}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base06},  #${colors.base06},  #${colors.base06},  #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base06},   #${colors.base00}, #${colors.base06},  #${colors.base00}, #${colors.base06},  #${colors.base06}
        inactive_colors=#${colors.base0F},          #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base0F},           #${colors.base0F},           #${colors.base0F},           #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base0F},            #${colors.base00}, #${colors.base0F},           #${colors.base00}, #${colors.base0F}, #${colors.base06}
      '';
      ".config/qt5ct/colors/stylix.conf".text = ''
        #               FG              BTN_BG bright less brdark        less da     txt fg               br text              btn fg           txt bg     bg     shadow   sel bg     sel fg     link       visited           alt bg default          tooltip bg  tooltip_fg	placeholder_fg
        [ColorScheme]
        active_colors=#${colors.base0F},          #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base0F},           #${colors.base0F},           #${colors.base0F},           #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base0F},            #${colors.base00}, #${colors.base0F},           ${colors.base00},  #${colors.base0F}, #${colors.base06}
        disabled_colors=#${colors.base06}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base06},  #${colors.base06},  #${colors.base06},  #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base06},   #${colors.base00}, #${colors.base06},  #${colors.base00}, #${colors.base06},  #${colors.base06}
        inactive_colors=#${colors.base0F},          #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base00}, #${colors.base0F},           #${colors.base0F},           #${colors.base0F},           #${colors.base00}, #${colors.base00}, #${colors.base00}, ${colors.base01}, #${colors.base00}, ${colors.base01}, #${colors.base0F},            #${colors.base00}, #${colors.base0F},           #${colors.base00}, #${colors.base0F}, #${colors.base06}
      '';
    };
  };
}
