{ lib, config, pkgs,... }:
with lib;
{
  config = mkIf config.nmod.sops.enable {
    sops.secrets."protonvpn" = { };
    # Make sure the ovpn file does not contain the line `auth-user-pass`
    environment.shellAliases.pvpn = "sudo ${lib.getExe pkgs.openvpn} --auth-user-pass ${config.sops.secrets."protonvpn".path} --config $@";
  };
}
