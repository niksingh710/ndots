{ opts, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "${opts.username}";
      userEmail = "${opts.userEmail}";
      extraConfig = {
        init.defaultBranch = "master";
        core.editor = "vim";
      };
    };
    gh.enable = true;
    lazygit = {
      enable = true;
      settings.gui.nerdFontsVersion = "3";
    };
  };
}
