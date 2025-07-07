{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";
  home.packages = [ pkgs.nvix ];

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
}
