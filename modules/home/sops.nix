{ flake, config, ... }:
let
  inherit (flake) inputs self;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    # TODO: Convert to a json file
    defaultSopsFile = "${self}/secrets/keys.yaml";
  };
}
