{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      maintenance = {
        enable = true;
        repositories = [
          "$HOME/work/nixpkgs"
        ];
      };
      ignores = [ "*~" "*.swp" ];
      lfs.enable = true;
      aliases = {
        gl = "log --oneline --graph --decorate";
      };
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
