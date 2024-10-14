{ inputs, lib, config, pkgs, ... }:
with lib;
let inherit (config.hmod) sops;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  options.hmod.sops = {
    enable = mkEnableOption "sops";
    keyFile = mkOption {
      type = types.str;
      default = "/persistent/var/lib/sops/age/keys.txt";
      description = "Sops Key path";
    };
  };

  config = mkIf sops.enable {
    home = {
      packages = [ pkgs.sops ];
      activation = {
        # This will run the service and allow sops to create entries in home dir
        setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          /run/current-system/sw/bin/systemctl restart --user sops-nix
        '';
      };
    };

    sops = {
      defaultSopsFile = ../../secrets/keys.yaml;
      age.keyFile = sops.keyFile;

      secrets = {
        "private-keys/ssh" = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        };
        "private-keys/age" = {
          path = "${config.home.homeDirectory}/.cofnig/sops/age/keys.txt";
        };
        hotspot-password = { };
        netrc = { path = "${config.home.homeDirectory}/.netrc"; };
        calendar-nvim = {
          path =
            "${config.home.homeDirectory}/.config/calendar.vim/credentials.vim";
        };
      };
    };
  };
}
