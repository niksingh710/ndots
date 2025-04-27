{ pkgs, lib, ... }: with lib;

{
  home = {
    # making some binaries to be available in the shell
    # specific to wayland/hyprland
    packages = with pkgs; [ grim slurp wl-clipboard ];
    shellAliases = {
      copy = "wl-copy";
      paste = "wl-paste";
    };
  };

  # Enables copy for wl-clipboard in zsh-vi-mode
  programs.zsh.initContent = # sh
    ''
      zvm_vi_yank () {
        zvm_yank
        printf %s "''${CUTBUFFER}" | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
        zvm_exit_visual_mode
      }
    '';

  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
