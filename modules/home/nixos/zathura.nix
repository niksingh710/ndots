{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set window-title-home-tilde true
      set statusbar-basename true
      set selection-clipboard clipboard

      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      set statusbar-h-padding 0
      set statusbar-v-padding 0
      set page-padding 1
      set database "sqlite"
      set guioptions ""

      map u scroll half-up
      map d scroll half-down
      map D toggle_page_mode
      map R reload
      map r rotate
      map J zoom in
      map K zoom out
      map i recolor
      set recolor true
    '';
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/vnd.ms-powerpoint" = "org.pwmt.zathura.desktop";
  };

}
