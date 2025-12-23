{ flake, pkgs, ... }:
{
  imports = [
    flake.flakeModules.nix
    flake.nixosModules.stylix
  ];

  home-manager.sharedModules = [
    flake.homeModules.default
  ];

  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  environment.systemPackages = with pkgs; [
    # ensuring some packages to be available for every user
    bash
    coreutils
    curl
    wget
    git
    gnutar
    gzip
    xz
    openssh
  ];
}
