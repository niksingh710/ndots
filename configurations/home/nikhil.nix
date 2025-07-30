{ flake, ... }:
let
  inherit (flake) self;
in
{
  imports = [
    self.homeModules.default
  ];
  home.username = "nikhil";
}
