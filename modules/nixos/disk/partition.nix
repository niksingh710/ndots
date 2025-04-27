{
  config,
  lib,
  inputs,
  self,
  ...
}:
with lib;
let
  cfg = config.ndots.disk;
in
{
  imports = [ inputs.disko.nixosModules.disko ];

  config = mkMerge [
    (import "${self}/disko/partition.nix" {
      ssd = cfg.ssd.enable;
      ssdOptions = cfg.ssd.options;
      inherit lib;
      inherit (cfg) impermanence encrypted;
    })
  ];

}
