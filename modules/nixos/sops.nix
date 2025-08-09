{ flake, ... }:
let
  inherit (flake) inputs self;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/var/sops/age/keys.txt";
    # TODO: Convert to a json file
    defaultSopsFile = "${self}/secrets/keys.yaml";
  };
}
