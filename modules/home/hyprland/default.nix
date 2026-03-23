{ pkgs, ... }:
{
  imports =
    with builtins;
    map (file: ./${file}) (filter (file: (file != "default.nix")) (attrNames (readDir ./.)));

  programs.zsh.profileExtra = # sh
    ''
      if [[ -z "$SSH_CONNECTION" ]] && [[ -n "$XDG_VTNR" ]] && uwsm check may-start && [[ -z "$TMUX" ]]; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  home = {
    # making some binaries to be available in the shell
    # specific to wayland/hyprland
    packages = with pkgs; [
      grim
      slurp
      wl-clipboard
    ];
    shellAliases = {
      copy = "wl-copy";
      paste = "wl-paste";
    };
  };
}
