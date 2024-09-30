{ inputs, lib, config, pkgs, ... }:
with lib;
let inherit (config.core) sops;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  options.core.sops = mkEnableOption "sops";

  config = mkIf sops {
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
      age.keyFile = "/var/lib/sops/age/keys.txt";

      secrets = {
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
