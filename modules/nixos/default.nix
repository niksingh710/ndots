{ flake, ... }:
let
  inherit (flake) self;
in
{
  imports = [
    self.nixosModules.common
    self.nixosModules.security
    self.nixosModules.boot
    self.nixosModules.shell
    self.nixosModules.services
    self.nixosModules.zram
    self.nixosModules.bluetooth
    self.nixosModules.audio
    self.nixosModules.networking

    self.nixosModules.stylix
    (self + /modules/home/stylix/config.nix)
  ];

  home-manager.sharedModules = [
    self.homeModules.default
    self.homeModules.packages
    self.homeModules.terminal
  ];
}
