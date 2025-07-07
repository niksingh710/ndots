{ pkgs, lib, ... }:
let
  clipboard =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "pbcopy"
    else
      "wlcopy";
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      append = true;
      expireDuplicatesFirst = true;
    };

    localVariables.ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
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
      {
        name = "zsh-system-clipboard";
        src = pkgs.zsh-system-clipboard;
        file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
      }
    ];
    profileExtra = lib.optionalString pkgs.stdenv.hostPlatform.isLinux # sh
      ''
        export ZSH_SYSTEM_CLIPBOARD_USE_WL_CLIPBOARD="wl-clipboard"
      '';
    initContent = lib.mkOrder 1500 # sh
      ''
        # `ctrl + j` and `ctrl + k` to navigate through suggestions
        bindkey '^[j' fzf-tab-complete
        bindkey '^[k' fzf-tab-complete

        function zvm_vi_yank() {
          zvm_yank
          echo ''${CUTBUFFER} | ${clipboard}
          zvm_exit_visual_mode
        }

        # user can add session based alias and fn for quick use
        [ -f "$HOME/.temp.zsh" ] && source "$HOME/.temp.zsh"
      '';
  };
}
