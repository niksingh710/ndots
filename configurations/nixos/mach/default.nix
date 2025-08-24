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

  hm.home.sessionVariables.SOPS_AGE_KEY_FILE = config.sops.age.keyFile;

  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    self.nixosModules.default
    self.nixosModules.secure-boot
    self.nixosModules.sops
    self.nixosModules.tailscale
    ./hardware.nix
    ./disk.nix
  ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = pubKeys;
  sops.secrets.user-password.neededForUsers = true;
  security.sudo.wheelNeedsPassword = false;
  # user Setup
  users.groups.${username} = { };
  users.users.${username} = {
    name = username;
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" ];
    isNormalUser = true;
    # TODO: To be investigated not working for some reason
    # hashedPasswordFile = config.sops.secrets.user-password.path;
    initialPassword = "password";
    group = username;

    openssh.authorizedKeys.keys = pubKeys;
  };

  # To avoid suspending
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchDocked=ignore
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore
  '';
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

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
