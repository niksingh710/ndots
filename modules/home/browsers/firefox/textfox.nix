{
  inputs,
  config,
  opts,
  pkgs,
  ...
}:
let
  inherit (config.lib.stylix) colors;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  imports = [
    inputs.textfox.homeManagerModules.default
  ];

  textfox = with colors; {
    enable = config.ndots.browser.firefox.textfox;
    profile = "default";
    config = {
      # Optional config
      background.color = if isLinux then "#${base00}" else "#000000";
      border = {
        color = if isLinux then "#${base06}" else "#bdbdbd";
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
      font =
        if isLinux then
          {
            family = config.stylix.fonts.monospace.name;
            accent = if isLinux then "#${base06}" else "#bdbdbd";
          }
        else
          {
            family = "JetBrainsMono Nerd Font Mono";
            accent = if isLinux then "#${base06}" else "#bdbdbd";
          };
    };
  };
}
