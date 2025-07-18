# Configuration for my MacBook Pro
{ flake, lib, ... }:
let
  inherit (flake) self;
  inherit (flake.config.me) username fullname email;
in
{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "mach";

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN.UTF-8";

  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    self.nixosModules.default
    self.nixosModules.secure-boot
    ./hardware.nix
    ./disk.nix
  ];
  security.sudo.wheelNeedsPassword = false;
  # user Setup
  users.users.${username} = {
    name = fullname;
    home = "/Users/${username}";
    extraGroups = [ "networkmanager" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
    ];
  };
  home-manager.backupFileExtension = "";
  home-manager.users.${username} = {
    imports = [
      self.homeModules.sops
    ];
    programs.git = {
      userName = fullname;
      userEmail = email;
    };
  };

  nix.settings.trusted-users = [ username ];
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "25.05";
}
