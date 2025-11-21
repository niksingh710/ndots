{ pkgs, ... }:
{
  home.shellAliases = {
    git-addnospace = "git diff -U0 -w --no-color --src-prefix=a/ --dst-prefix=b/ | git apply --cached --ignore-whitespace --unidiff-zero -";
  };
  programs = {
    git = {
      enable = true;
      maintenance = {
        enable = true;
        repositories = [
          "$HOME/work/nixpkgs"
        ];
      };
      ignores = [
        "*~"
        "*.swp"
      ];
      lfs.enable = true;
      iniContent = {
        branch.sort = "-committerdate";
      };
      settings = {
        aliases = {
          gl = "log --oneline --graph --decorate";
        };
        init.defaultBranch = "master";
        core.editor = "nvim";
        core.sharedRepository = "group";
        credential.helper = "store --file ~/.git-credentials";
        pull.rebase = "false";
        diff.wsErrorHighlight = "none";
        apply.whitespace = "nowarn";
      };
    };
    gh = {
      enable = true;
      extensions = [
        pkgs.gh-notify
      ];
    };
    lazygit = {
      enable = true;
      settings.gui = {
        nerdFontsVersion = "3";
        theme.lightTheme = false;
      };
    };
  };
}
