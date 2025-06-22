{
  programs = {
    git = {
      enable = true;
      ignores = [ "*~" "*.swp" ];
      lfs.enable = true;
      iniContent = {
        branch.sort = "-committerdate";
      };
      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "nvim";
        core.sharedRepository = "group";
        credential.helper = "store --file ~/.git-credentials";
        pull.rebase = "false";
      };
    };
    gh.enable = true;
    lazygit = {
      enable = true;
      settings.gui.theme.lightTheme = false;
    };
  };
}
