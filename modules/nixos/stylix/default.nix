{
  inputs,
  self,
  config,
  lib,
  pkgs,
  opts,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = import "${self}/modules/home/stylix/config.nix" {
    inherit
      opts
      pkgs
      config
      lib
      ;
  };
}
