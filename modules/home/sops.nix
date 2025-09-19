{ flake, config, ... }:
{
  imports = [
    flake.inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    # private age key file location
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    # TODO: Convert to a json file
    defaultSopsFile = "${flake}/secrets/keys.yaml";
  };
}
