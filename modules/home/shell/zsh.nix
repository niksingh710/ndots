{ pkgs, ... }: {
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "viins";
      enableCompletion = true;

      history = {
        path = "$HOME/.cache/zsh/.history";
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreSpace = true;
      };

      plugins = with pkgs; [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "zsh-autosuggestions";
          src = zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-you-should-use";
          src = zsh-you-should-use;
          file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        }
        {
          name = "F-Sy-H";
          inherit (zsh-f-sy-h) src;
        }

      ];

      envExtra = # sh
        ''
          ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
        '';

      initExtra = # sh
        ''
          function zvm_after_init() {
            zvm_bindkey viins "^R" fzf-history-widget
          }
          bindkey '^ ' autosuggest-accept
        '';

    };
  };
}
