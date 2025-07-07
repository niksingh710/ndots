{ config, ... }:
{
  # system level overrides for darwin

  nix.extraOptions = # conf
    ''
      !include ${config.hm.sops.secrets."private-keys/nix_access_token".path}
    '';
}
