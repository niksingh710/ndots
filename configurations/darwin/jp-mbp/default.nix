# Configuration for my MacBook Pro
{ flake, lib, ... }:
let
  inherit (flake) inputs;
  inherit (flake.config.me) email;
  inherit (inputs) self;

  # NOTE: If the configuration requires multiple users
  #       then add a users dir and utilize that.
  username = "nikhil.singh";
  fullname = username;
in
{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    self.darwinModules.default
    ./overrides.nix
  ];

  # user Setup
  users.users.${username} = {
    name = fullname;
    home = "/Users/${username}";
  };
  home-manager.backupFileExtension = "";
  home-manager.users.${username} = {
    imports = [
      self.homeModules.sops
      self.homeModules.darwin
      ./secrets.nix
    ];
    programs.git = {
      userName = username;
      userEmail = email;
    };
  };
  environment.etc."sudoers.d/10-nix-sudo".text =
    ''
      ${username} ALL=(ALL:ALL) NOPASSWD: ALL
    '';

  system.primaryUser = username;
  nix.settings.trusted-users = [ username ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "jp-mbp";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
