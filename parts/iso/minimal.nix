# Minimal Iso stands for CLI variant only
{
  inputs,
  pkgs,
  modulesPath,
  hostPlatform,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    # To install hyprland quickly
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://cache.nixos.asia/oss"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  nixpkgs = {
    inherit hostPlatform;
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        git
        disko
      ]
      ++ ([
        inputs.nvix.packages.${pkgs.system}.bare # My neovim config based on Nixvim
      ]);
    shellAliases = {
      vim = "nvim";
    };
  };

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  users.users =
    let
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
      ];
    in
    {
      root.openssh.authorizedKeys = {
        inherit keys;
      };
      nixos.openssh.authorizedKeys = {
        inherit keys;
      };
    };
}
