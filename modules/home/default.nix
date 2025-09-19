{ flake, pkgs, ... }:
{
  # This has to be same for darwin/home-manager/nixOs.
  home.stateVersion = "25.05";
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [ monaspace ];

  # I believe no matter the distro/Os,
  # User should have nice cli setup on any device.
  imports = [
    flake.homeModules.shell
    flake.homeModules.editor
    flake.homeModules.ssh
    flake.homeModules.nix-index
  ];
}
