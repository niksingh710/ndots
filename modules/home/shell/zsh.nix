{ pkgs, lib, ... }:
let
  zshSysClip =
    lib.optionalString pkgs.stdenv.hostPlatform.isLinux # sh
      ''
        export ZSH_SYSTEM_CLIPBOARD_USE_WL_CLIPBOARD="wl-clipboard"
      '';
  copy = pkgs.writeShellScriptBin "copy" ''
    printf "\033]52;c;%s\007" "$(base64 | tr -d '\n')"
  '';

in
{
  home.packages = [ copy ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      append = true;
      expireDuplicatesFirst = true;
    };
    profileExtra = # sh
      ''
        ${zshSysClip}
      '';
    localVariables = {
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
      ZVM_CLIPBOARD_COPY_CMD = "${lib.getExe copy}";
      ZVM_SYSTEM_CLIPBOARD_ENABLED = "true";
    };
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
    initContent =
      lib.mkOrder 1500 # sh
        ''
          # `ctrl + j` and `ctrl + k` to navigate through suggestions
          bindkey '^[j' fzf-tab-complete
          bindkey '^[k' fzf-tab-complete

          # user can add session based alias and fn for quick use
          [ -f "$HOME/.temp.zsh" ] && source "$HOME/.temp.zsh"
        '';
  };
}
