{ pkgs, ... }:
let
  # pick any name from <https://tinted-theming.github.io/tinted-gallery/>
  # if base16Scheme is not set the color from wallpapers will be used
  scheme = "catppuccin-mocha";
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lordofhunger/wallpapers/refs/heads/master/wallpapers/1%20-%20digital%20art/12-programming/004-computer.png";
      sha256 = "bfa09025eb43156d3391d3f665e8d4ba8378402a8ac292b63aade199911d92cb";
    };
    opacity.terminal = 0.4;
    polarity = "dark";
    fonts.monospace = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };
}
