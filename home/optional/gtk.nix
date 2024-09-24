{ pkgs, ... }: {
  home.packages = with pkgs; [ nautilus ];
  gtk = {
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    enable = true;
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };
  };
}
