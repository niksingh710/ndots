{ pkgs, ... }:
# This is zsh config
# You may need to make zsh as your default shell
{

  home.packages = with pkgs; [ nix-zsh-completions ];
  programs = {
    zsh = {
      enable = true;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      enableVteIntegration = true;
      autocd = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        append = true;
        expireDuplicatesFirst = true;
        path = "$HOME/.cache/zsh/.history";
      };

      localVariables = {
        ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
      };

      initContent = # sh
        ''
          bindkey '^ ' autosuggest-accept # Makes `ctrl + space` to accept autosuggestions

          bindkey '^[j' fzf-tab-complete
          bindkey '^[k' fzf-tab-complete

          # user can add session based alias and fn for quick use
          [ -f "$HOME/.temp.zsh" ] && source "$HOME/.temp.zsh"
        '';

      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "zsh-fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
