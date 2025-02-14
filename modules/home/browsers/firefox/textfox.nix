{ inputs, config, opts, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  imports = [
    inputs.textfox.homeManagerModules.default
  ];

  textfox = with colors;{
    enable = config.ndots.browser.firefox.textfox;
    profile = "default";
    config = {
      # Optional config
      background.color = "#${base00}";
      border = {
        color = "#${base06}";
        width = "1px";
        radius = if opts.rounding then "10px" else "0px";
      };
      displayWindowControls = false;
      displayNavButtons = true;
      displayTitles = false;
      newtabLogo = # text
        ''
            __ _           __
           / _(_)_ __ ___ / _| _____  __
          | |_| | '__/ _ \ |_ / _ \ \/ /
          |  _| | | |  __/  _| (_) >  <
          |_| |_|_|  \___|_|  \___/_/\_\

        '';
      font = {
        family = config.stylix.fonts.monospace.name;
        accent = "#${base06}";
      };
    };
  };
}
