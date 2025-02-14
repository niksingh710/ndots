{ pkgs, config, ... }: {
  enable = true;
  autoEnable = true;
  polarity = "dark";
  image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/pixelart/dock.png";
    sha256 = "b7e95e0874aea54c0af2afdb1976f7389a5fd12b84905c57dbbb65168f06c6ff";
  };
  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

  opacity = {
    terminal = 1.0;
    popups = 0.8;
  };

  cursor = {
    package = pkgs.volantes-cursors;
    name = "volantes_cursors";
    size = 24;
  };

  fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
  };
}
