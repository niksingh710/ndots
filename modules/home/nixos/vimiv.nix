{
  pkgs,
  lib,
  config,
  ...
}:
with config.lib.stylix.colors;
{
  home.packages = with pkgs; [ vimiv-qt ];

  home.file = {
    ".config/vimiv/vimiv.conf".text = lib.generators.toINI { } {
      GENERAL = {
        style = "stylix";
      };
    };
    ".config/vimiv/styles/stylix".text = lib.generators.toINI { } {
      STYLE = {
        base00 = "#${base00}";
        base01 = "#${base01}";
        base02 = "#${base02}";
        base03 = "#${base03}";
        base04 = "#${base04}";
        base05 = "#${base05}";
        base06 = "#${base06}";
        base07 = "#${base07}";
        base08 = "#${base08}";
        base09 = "#${base09}";
        base0a = "#${base0A}";
        base0b = "#${base0B}";
        base0c = "#${base0C}";
        base0d = "#${base0D}";
        base0e = "#${base0E}";
        base0f = "#${base0F}";
      };
    };
  };
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "vimiv.desktop";
    "image/gif" = "vimiv.desktop";
    "image/webp" = "vimiv.desktop";
    "image/png" = "vimiv.desktop";
    "image/svg+xml" = "vimiv.desktop";
  };
}
