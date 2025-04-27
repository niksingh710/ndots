# Minimal Iso stands for CLI variant only
{
  inputs,
  pkgs,
  modulesPath,
  self,
  hostPlatform,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    self.nixosModules.home-manager
    self.nixosModules.shell
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    # To install hyprland quickly
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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

  networking = {
    networkmanager.enable = true;

    # This does not disable wifi
    # It is just an minimal alternative to Network manager
    wireless.enable = false;
  };

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
