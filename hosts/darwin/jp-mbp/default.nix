{ flake, lib, config, ... }:
let
  me = (import (flake + "/config.nix")).me // {
    username = "nikhil.singh";
  };
in
{

  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" config.system.primaryUser ])
    flake.darwinModules.default

    flake.darwinModules.yabai
  ];

  # Primary user setup
  users.users.${me.username} = {
    name = me.username;
    openssh.authorizedKeys.keys = me.sshPublicKeys;
  };

  hm.sops.secrets."private-keys/nix_access_token" = { };
  nix.extraOptions = # conf
    ''
      !include ${config.hm.sops.secrets."private-keys/nix_access_token".path}
    '';

  environment.etc."sudoers.d/10-nix-sudo".text = ''
    ${me.username} ALL=(ALL:ALL) NOPASSWD: ALL
  '';

  system.primaryUser = me.username;
  nix.settings.trusted-users = [ me.username ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
