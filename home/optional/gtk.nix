{ pkgs, ... }: {
  home.packages = with pkgs; [ nautilus ];
  persist.dir = [ ".config/gtk-3.0" ".config/gtk-2.0" ".config/gtk-1.0" ];
  gtk = {
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    enable = true;
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };
  };
}
