{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ nautilus ];
  gtk = {
    enable = true;
    theme.package = lib.mkForce pkgs.stable.adw-gtk3;
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };
  };
}
