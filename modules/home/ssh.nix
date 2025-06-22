{ lib, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
  };
  services.ssh-agent = lib.mkIf pkgs.stdenv.isLinux { enable = true; };
}
