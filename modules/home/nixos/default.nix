# Programs/packages for nixos
{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  utils = inputs.utils.packages.${pkgs.system};
  nix-alien = inputs.nix-alien.packages.${pkgs.system};
in
{
  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );

  nixGL = {
    vulkan.enable = true;
    packages = inputs.nixgl.packages;
  };
  home.shellAliases = {
    rdrag = "${lib.getExe pkgs.ripdrag} -s 128 -r -x -a -n -b";
    dopen = "setsid xdg-open $@ &>/dev/null";
    d = "setsid $@ &>/dev/null";
  };
  services.udiskie = {
    enable = true;
    automount = false;
  };

  stylix.iconTheme = {
    enable = true;
    package = pkgs.qogir-icon-theme;
    dark = "Qogir-Dark";
    light = "Qogir-Dark";
  };

  home.packages =
    with pkgs;
    [
      fractal
      whatsapp-for-linux
      deluge

      proton-pass
      ripdrag

      libnotify

      (config.lib.nixGL.wrap pkgs.onlyoffice-bin_latest)
    ]
    ++ [
      # utils.center-align
      # utils.bstat
      utils.icpu
      nix-alien.nix-alien
    ];
}
