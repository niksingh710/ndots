{ flake, ... }:
let
  inherit (flake) self;
in
{
  imports = [
    self.nixosModules.common
    self.darwinModules.settings
    self.darwinModules.packages
  ];

  home-manager.sharedModules = [
    self.homeModules.default
  ];

  # use homeModules.nix for nix configuration in standalone home-manager setups.
  # Nix configuration is managed globally by nix-darwin.
  # Prevent $HOME nix.conf from disrespecting it.
  hm.home.file.".config/nix/nix.conf".text = "";
}
