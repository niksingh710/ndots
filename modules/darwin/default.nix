{ flake, ... }:
let
  inherit (flake) self inputs;
in
{
  imports = [
    self.nixosModules.common
    self.darwinModules.settings
    self.darwinModules.packages
    inputs.mac-app-util.darwinModules.default

    self.darwinModules.stylix
    (self + /modules/home/stylix/config.nix)
  ];

  home-manager.sharedModules = [
    self.homeModules.default
    self.homeModules.packages
    self.homeModules.terminal

    # FIXME: Get sine build with the package to make it use with nebula
    # TRACK: if <https://github.com/CosmoCreeper/Sine/issues/274> this get's fixed
    # Then override fix can work with it's.
    self.homeModules.browser
  ];
}
