{
  flake,
  lib,
  config,
  ...
}:
let
  me = (import (flake + "/config.nix")).me // {
    username = "virt";
  };
in
{
  # TODO: Follow up to complete
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" me.username ])
    flake.nixosModules.default

    # Important for the hardware
    ./disk.nix
  ];

  # Primary user setup
  users.users.${me.username} = {
    name = me.username;
    # home = "/home/${me.username}";
    openssh.authorizedKeys.keys = me.sshPublicKeys;
  };

  environment.etc."sudoers.d/10-nix-sudo".text = ''
    ${me.username} ALL=(ALL:ALL) NOPASSWD: ALL
  '';

  nix.settings.trusted-users = [ me.username ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}
