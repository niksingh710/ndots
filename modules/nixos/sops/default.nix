{ inputs, pkgs, lib, config, opts, ... }: with lib;
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = mkMerge [
    {
      hm.ndots.sops.keyFile =
        # TODO: fix cross link modules disk/sops
        if config.ndots.disk.impermanence then
          "/persistent/var/lib/sops/age/keys.txt"
        else
          "/var/lib/sops/age/keys.txt";

    }

    (mkIf config.hm.ndots.sops.enable {
      sops = {
        secrets = mkMerge [
          {
            "protonvpn" = { };
          }
          (mkIf config.hm.ndots.sops.enable {
            user-password.neededForUsers = true;
          })
        ];
        defaultSopsFile = "${config.hm.ndots.sops.defaultSopsFile}";
        age.keyFile = "${config.hm.ndots.sops.keyFile}";
      };

      # Make sure the ovpn file does not contain the line `auth-user-pass`
      environment.shellAliases.pvpn = "sudo ${lib.getExe pkgs.openvpn} --auth-user-pass ${config.sops.secrets."protonvpn".path} --config $@";

      users.users.${opts.username} = {
        hashedPasswordFile = config.sops.secrets.user-password.path;
        password = mkForce null;
      };
    })
  ];
}
