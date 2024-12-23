{ opts, pkgs, config, lib, ... }: with lib;{
  enable = true;
  autoEnable = true;
  polarity = "dark";
  image = "${opts.wallpaper}";
  base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";

  opacity = mkIf opts.transparency {
    terminal = 0.9;
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
