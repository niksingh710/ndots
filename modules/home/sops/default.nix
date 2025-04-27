# This is not meant to be used by other users
# Use only if you understand what is going on.
# This contains my config for sops
# It expects the private `age` key to be already present
# at /var/lib/sops/age/keys.txt
# If using impermanence then point it to a persistent location
{
  inputs,
  pkgs,
  lib,
  config,
  self,
  ...
}:
with lib;
let
  cfg = config.ndots;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  config = mkIf cfg.sops.enable {
    home = {
      packages = [ pkgs.sops ]; # get sops binary in PATH
      activation = {
        # This will run the service and allow sops to create entries in home dir
        setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          /run/current-system/sw/bin/systemctl restart --user sops-nix
        '';
      };
    };

    sops = {
      inherit (cfg.sops) defaultSopsFile;
      age = {
        inherit (cfg.sops) keyFile;
      };

      secrets = {
        "private-keys/ssh".path = "${config.home.homeDirectory}/.ssh/id_rsa";
        "private-keys/age".path = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };

  };

  options.ndots.sops = {
    enable = mkEnableOption "sops";
    defaultSopsFile = mkOption {
      type = types.path;
      default = "${self}/secrets/keys.yaml";
      description = "Path to the default sops file";
    };
    keyFile = mkOption {
      type = types.str;
      default = "/var/lib/sops/age/keys.txt";
      description = "Path to the key file";
    };
  };
}
