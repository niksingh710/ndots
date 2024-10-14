{
  persist.dir = [ ".local/share/direnv" ];
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
