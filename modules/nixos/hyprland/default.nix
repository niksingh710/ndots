{ inputs, self, pkgs, opts, lib, config, ... }: with lib;
{
  programs.hyprland =
    let
      hyprland = inputs.hyprland.packages.${pkgs.system};
    in
    {
      enable = true;
      package = hyprland.hyprland;
      portalPackage = hyprland.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

  # Starts the hyprland session as soon as the user logs in
  hm.programs.zsh.profileExtra = # sh
    ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';


  # For quick addition to avoid building from scratch
  # export NIX_CONFIG="substituters = https://cache.nixos.org https://hyprland.cachix.org\ntrusted-public-keys = hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  hm.wayland.windowManager.hyprland.package = config.programs.hyprland.package; # overrides the home-manager's hyprland package
  services.getty.autologinUser = "${opts.username}";
  security.pam.services.hyprlock.text = "auth include login";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # if you also want 32-bit support (e.g for Steam)
  hardware.graphics.enable32Bit = mkForce true;

  hm.imports = [ self.homeModules.hyprland ];
}
