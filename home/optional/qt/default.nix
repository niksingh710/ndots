{ lib, config, ... }: {
  imports = [
    ./kvdark.nix
  ];
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "qtct";
  };

  home.file =
    let
      baseConfig = {
        Appearance = {
          custom_palette = false;
          style = "kvantum-Dark";
          icon_theme = config.gtk.iconTheme.name;
        };
      };
    in
    {
      ".config/qt5ct/qt5ct.conf".text = lib.generators.toINI { } (baseConfig
        // {
        Fonts.fixed = "\"${config.stylix.fonts.monospace.name},${toString config.stylix.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular\"";
        Fonts.general = "\"${config.stylix.fonts.sansSerif.name},${toString config.stylix.fonts.sizes.applications},-1,5,50,0,0,0,0,0,Regular\"";
      });
      ".config/qt6ct/qt6ct.conf".text = lib.generators.toINI { } (baseConfig
        // {
        Fonts.fixed = "\"${config.stylix.fonts.monospace.name},${toString config.stylix.fonts.sizes.applications},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
        Fonts.general = "\"${config.stylix.fonts.sansSerif.name},${toString config.stylix.fonts.sizes.applications},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
      });
    };
}
