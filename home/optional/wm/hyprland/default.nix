{ pkgs, lib, ... }: {

  services.hyprpaper.enable = lib.mkForce false;

  imports = [
    ./env.nix
    ./exec.nix
    ./rules.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./monitor.nix
    ./keymaps.nix
    ./swaync.nix

    ./rofi
    ./waybar
  ];

  home = {
    packages = with pkgs; [ grim slurp wl-clipboard cliphist swww ];
    shellAliases = {
      copy = "wl-copy";
      paste = "wl-paste";
    };
  };

  programs.zsh = {
    initExtra = # sh
      ''
        zvm_vi_yank () {
          zvm_yank
          printf %s "''${CUTBUFFER}" | wl-copy
          zvm_exit_visual_mode
        }
      '';
    profileExtra = "pgrep -x Hyprland &>/dev/null || Hyprland &>/dev/null";
  };

}