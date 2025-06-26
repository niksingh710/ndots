# These are home-manager modules/configs.
# For Darwin Only.
{ flake, ... }:
let
  inherit (flake) inputs;
in
{
  imports =
    with builtins;
    map (file: ./${file})
      (
        filter (file: (file != "default.nix")) (attrNames (readDir ./.))
      ) ++ [
      inputs.mac-app-util.homeManagerModules.default
    ];
}
