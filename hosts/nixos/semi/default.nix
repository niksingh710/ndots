{
  flake,
  lib,
  pkgs,
  ...
}:
let
  me = (import (flake + "/config.nix")).me // {
    username = "nikhil.singh";
  };
in
{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" me.username ])
    flake.nixosModules.default

    # Important for the hardware
    flake.inputs.disko.nixosModules.disko
    ./disk.nix
    # should be generated sudo nixos-generate-config --show-hardware-config --root /mnt > ./hosts/nixos/{host}/hardware.nix>
    ./hardware.nix
    # extra-users added in the system
    ./extra-users.nix
  ];

  environment.variables = {
    TERM = "xterm-256color";
    ZSH_DISABLE_COMPFIX = "true";
  };

  programs.zsh.enable = true;
  # Primary user setup
  users = {
    defaultUserShell = pkgs.zsh;
    groups.extra = { };
    users.${me.username} = {
      name = me.username;
      home = "/home/${me.username}";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "extra"
        "docker"
      ];
      openssh.authorizedKeys.keys = me.sshPublicKeys;
    };
  };

  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    extraConfig = # sshd_config
      ''
        AcceptEnv LANG LC_* ANTHROPIC_MODEL ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS
      '';
  };
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  networking = {
    stevenblack.enable = true;
    networkmanager.enable = true;

    # This does not disable wifi
    # It is just an minimal alternative to Network manager
    wireless.enable = lib.mkForce true;
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };
  security.sudo.wheelNeedsPassword = false;

  nix.settings.trusted-users = [ me.username ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}
