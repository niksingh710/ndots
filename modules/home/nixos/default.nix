# Programs/packages for nixos
{ inputs, lib, pkgs, ... }: with lib;
let
  utils = inputs.utils.packages.${pkgs.system};
  nix-alien = inputs.nix-alien.packages.${pkgs.system};
in
{
  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));


  home.shellAliases = {
    rdrag = "${lib.getExe pkgs.ripdrag} -s 128 -r -x -a -n -b";
    dopen = "setsid xdg-open $@ &>/dev/null";
    d = "setsid $@ &>/dev/null";
  };
  services.udiskie = {
    enable = true;
    automount = false;
  };
  gtk.iconTheme = {
    name = "Qogir-dark";
    package = pkgs.qogir-icon-theme;
  };
  home.packages = with pkgs;
    [
      fractal
      whatsapp-for-linux

      onlyoffice-bin_latest
      deluge

      proton-pass
      ripdrag

      libnotify
    ]
    ++ [ utils.center-align utils.bstat nix-alien.nix-alien ];
}
