{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ nautilus ];
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    theme = {
      package = lib.mkForce pkgs.stable.adw-gtk3;
    };
    iconTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };
  };
}
