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
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreSpace = true;
      };

      plugins = with pkgs; [
        {
          name = "zsh-vim-mode";
          src = fetchFromGitHub {
            owner = "softmoth";
            repo = "zsh-vim-mode";
            rev = "1f9953b7d6f2f0a8d2cb8e8977baa48278a31eab";
            hash = "sha256-a+6EWMRY1c1HQpNtJf5InCzU7/RphZjimLdXIXbO6cQ=";
          };
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
          # Environment variables for vim mode
          MODE_CURSOR_VIINS="blinking bar"
          MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
          MODE_CURSOR_VICMD="block"
          MODE_CURSOR_SEARCH="steady underline"
          MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD block"
          MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL"
        '';

      initExtra = # sh
        ''
          bindkey '^ ' autosuggest-accept
          bindkey -M viins 'jk' vi-cmd-mode

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
