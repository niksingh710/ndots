{ pkgs, opts, ... }: {
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.stable.xdg-desktop-portal-hyprland;
  };

  services.getty.autologinUser = "${opts.username}";

  security.pam.services.hyprlock = { };

}
