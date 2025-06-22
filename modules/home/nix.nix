{ flake, ... }:
let
  inherit (flake) self;
in
{
  imports = [ self.nixosModules.common ];
}
