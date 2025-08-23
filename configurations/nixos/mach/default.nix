# Configuration for my MacBook Pro
{ flake, lib, config, ... }:
let
  inherit (flake) self;
  inherit (flake.config.me) username email;
  pubKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
  ];
in
{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "mach";

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    self.nixosModules.default
    self.nixosModules.secure-boot
    self.nixosModules.sops
    ./hardware.nix
    ./disk.nix
  ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = pubKeys;
  # sops.secrets.user-password.neededForUsers = true;
  security.sudo.wheelNeedsPassword = false;
  # user Setup
  users.groups.${username} = { };
  users.users.${username} = {
    name = username;
    home = "/home/${username}";
    extraGroups = [ "networkmanager" ];
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.user-password.path;
    password = "password";
    group = username;

    openssh.authorizedKeys.keys = pubKeys;
  };
  home-manager.backupFileExtension = "";
  home-manager.users.${username} = {
    imports = [
      self.homeModules.sops
    ];
    programs.git = {
      userName = username;
      userEmail = email;
    };
  };

  nix.settings.trusted-users = [ username ];
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "25.05";
}
