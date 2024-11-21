{ inputs, opts, pkgs, self, config, lib, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = import "${self}/home/core/stylix/config.nix" { inherit opts pkgs config lib; };
}
