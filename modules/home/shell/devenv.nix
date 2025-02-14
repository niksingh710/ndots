{ pkgs, ... }:
{
  home.packages = with pkgs; [
    devenv
  ];
  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      enableBashIntegration = true; # see note on other shells below
      enableZshIntegration = true; # see note on other shells below
    };
  };
}
