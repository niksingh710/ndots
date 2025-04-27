{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  walogram = inputs.utils.packages.${pkgs.system}.walogram.override {
    image = "${config.stylix.image}";
    colors = (
      with config.lib.stylix.colors;
      ''
        color0="#${base00}"
        color1="#${base01}"
        color2="#${base02}"
        color3="#${base03}"
        color4="#${base04}"
        color5="#${base05}"
        color6="#${base06}"
        color7="#${base07}"
        color8="#${base08}"
        color9="#${base09}"
        color10="#${base0A}"
        color11="#${base0B}"
        color12="#${base0C}"
        color13="#${base0D}"
        color14="#${base0E}"
        color15="#${base0F}"
      ''
    );
  };
in
{
  home.activation.tg-theme = lib.hm.dag.entryAfter [ "" ] ''
    run ${lib.getExe walogram}
  '';
}
