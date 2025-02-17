{ lib, inputs, pkgs, config, ... }: with lib;
let
  utils = inputs.utils.packages.${pkgs.system};
  term = if config.ndots.hyprland.terminal.kitty then "kitty" else "foot";
  quick-term = pkgs.writeScript "quick-term" ''
    #!/bin/bash
    export TERMINAL="${term}"
    ${lib.getExe utils.quick-term}
  '';
in
{
  config.wayland.windowManager.hyprland.settings.bind = [
    "CTRL,grave,exec,${quick-term}"
  ];


  options.ndots.hyprland.terminal = {
    foot = mkEnableOption "Enabling foot" // { default = true; };
    kitty = mkEnableOption "Enabling kitty";
  };

  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
