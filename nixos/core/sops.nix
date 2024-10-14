{ inputs, lib, config, opts, ... }:
with lib;
let inherit (config.nmod) sops;
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.nmod.sops = {
    enable = mkEnableOption "sops" // { default = config.hm.hmod.sops.enable; };
    keyFile = mkOption {
      type = types.str;
      default = config.hm.hmod.sops.keyFile;
      description = "sops age keyFile path";
    };
  };

  config = mkIf sops.enable {
    persist.dir = [ "/var/lib/sops/age" ];
    sops = {
      defaultSopsFile = ../../secrets/keys.yaml;
      age.keyFile = sops.keyFile;
      secrets."private-keys/age" = {
        owner = "${opts.username}";
        path = "/home/${opts.username}/.config/sops/age/keys.txt";
      };
    };
  };
}
