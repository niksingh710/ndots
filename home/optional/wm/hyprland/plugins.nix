{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland.plugins = [

    # FIXME: it is crashing
    # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails

  ];
}
