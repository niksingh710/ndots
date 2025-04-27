{ pkgs, config, ... }: {
  enable = true;
  autoEnable = true;
  polarity = "dark";
  image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/pixelart/gruvbox_image46.png";
    sha256 = "95f67683e0f3066423f321c6996d656839e14c442dc2f2fbe43bfd2cb1e01103";
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
