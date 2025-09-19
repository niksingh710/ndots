{
  home.sessionVariables = {
    _ZO_EXCLUDE_DIRS = "/nix";
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
}
