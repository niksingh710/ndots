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

          # printf '\n%.0s' {1..$LINES}
          # Transient fns in zsh
          function zle-line-init() {
            emulate -L zsh
            [[ $CONTEXT == start ]] || return 0

            while true; do
              zle .recursive-edit

              local -i ret=$?
              [[ $ret == 0 && $KEYS == $'\4' ]] || break
              [[ -o ignore_eof ]] || exit 0
            done

            local saved_prompt=$PROMPT
            local saved_rprompt=$RPROMPT
            # PROMPT='ﬦ '
            PROMPT='󰘧 '
            RPROMPT='''
            zle .reset-prompt
            PROMPT=$saved_prompt
            RPROMPT=$saved_rprompt

            if (( ret )); then
              zle .send-break
            else
              zle .accept-line
            fi
            return ret
          }

          zle -N zle-line-init
          precmd() { printf "" }

        '';

    };
  };
}
