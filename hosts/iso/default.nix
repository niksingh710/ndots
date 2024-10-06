{ pkgs, modulesPath, opts, self, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${self}/nixos/core/overlays"
  ];

  nixpkgs.hostPlatform = "${opts.platform}";

  environment = {
    systemPackages = with pkgs;[ git disko nvix-bare ];
    shellAliases = {
      vim = "nvim";
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
    ];
  };
}
