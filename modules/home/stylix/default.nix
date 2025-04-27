{
  inputs,
  opts,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  stylix = import ./config.nix {
    inherit
      opts
      pkgs
      config
      lib
      ;
  };
}
