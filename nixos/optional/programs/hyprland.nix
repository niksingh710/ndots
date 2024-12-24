{ pkgs, opts, lib, ... }: with lib;
{
  programs.hyprland = {
    enable = true;
    package = pkgs.wmhypr.hyprland;
    portalPackage = pkgs.wmhypr.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  services.getty.autologinUser = "${opts.username}";

  security.pam.services.hyprlock.text = "auth include login";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  hardware.graphics = {
    package = pkgs.mesa.drivers;

    # if you also want 32-bit support (e.g for Steam)
    enable32Bit = mkForce true;
    package32 = pkgs.pkgsi686Linux.mesa.drivers;
  };

}
