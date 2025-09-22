{ lib, pkgs, ... }:
{
  # Home-manager ssh config
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
      addKeysToAgent = "yes";
    };
  };
  # To avoid collision in home-manager
  # see: https://github.com/nix-community/home-manager/issues/4199
  home.file.".ssh/config".force = true;
  services.ssh-agent = lib.mkIf pkgs.stdenv.isLinux { enable = true; };
}
