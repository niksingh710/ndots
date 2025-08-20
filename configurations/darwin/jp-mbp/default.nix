# Configuration for my MacBook Pro
{ flake, lib, ... }:
let
  inherit (flake) self;
  inherit (flake.config.me) email;

  # NOTE: If the configuration requires multiple users
  #       then add a users dir and utilize that.
  username = "nikhil.singh";
  fullname = username;
in
{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    self.darwinModules.default
    self.darwinModules.yabai
    self.darwinModules.skhd
    ./overrides/nix-darwin.nix
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
      (self.homeModules.darwin + "/karabiner.nix")
      (self.homeModules.darwin + "/jankyborders.nix")
      self.homeModules.espanso
      self.homeModules.mpv
      ./secrets.nix
      ./overrides/home.nix
    ];
    programs.git = {
      userName = flake.config.me.fullname;
      userEmail = email;
      includes = [
        {
          condition = "gitdir:~/work/bitbucket/";
          contents.user.email = "${username}@juspay.in";
        }
      ];
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
