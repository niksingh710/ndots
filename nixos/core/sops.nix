{ inputs, opts, lib, config, ... }:
with lib;
let inherit (config.core) sops;
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.core.sops = mkEnableOption "sops";

  config = mkIf sops {
    persist.dir = [ "/var/lib/sops/age" ];
    sops = {
      defaultSopsFile = ../../secrets/keys.yaml;
      age.keyFile = "/persistent/var/lib/sops/age/keys.txt";

      secrets = {
        "private-keys/ssh" = {
          owner = "${opts.username}";
          path = "/home/${opts.username}/.ssh/id_ed25519";
        };
        "private-keys/age" = {
          owner = "${opts.username}";
          path = "/home/${opts.username}/.config/sops/age/keys.txt";
        };
      };
    };
  };
}
