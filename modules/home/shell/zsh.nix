{ pkgs, lib, ... }:
let
  zshSysClip =
    lib.optionalString pkgs.stdenv.hostPlatform.isLinux # sh
      ''
        export ZSH_SYSTEM_CLIPBOARD_USE_WL_CLIPBOARD="wl-clipboard"
      '';
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
    profileExtra = # sh
      ''
        ${zshSysClip}
      '';

    localVariables.ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
    plugins = [
      {
        name = "vi-mode";
        # TODO: remove once <https://github.com/NixOS/nixpkgs/pull/443356> merged to nixpkgs-unstable
        src = pkgs.zsh-vi-mode.overrideAttrs (oa: {
          src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "v0.12.0";
            hash = "sha256-EYr/jInRGZSDZj+QVAc9uLJdkKymx1tjuFBWgpsaCFw=";
          };
        });
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

          ZVM_SYSTEM_CLIPBOARD_ENABLED=true # <https://github.com/jeffreytse/zsh-vi-mode/pull/192#issuecomment-3296197531>

          # user can add session based alias and fn for quick use
          [ -f "$HOME/.temp.zsh" ] && source "$HOME/.temp.zsh"
        '';
  };
}
