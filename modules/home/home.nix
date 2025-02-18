{ pkgs, opts, ... }:
# Common settings for all type of system/users that home-manager should have.
# In General home-manager required defaults
let
  inherit (opts) username;
in
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    packages = [ pkgs.home-manager ];
    stateVersion = "25.05";
  };

  systemd.user.startServices = true;
}
