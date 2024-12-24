{ pkgs, lib, ... }: {

  services.hyprpaper.enable = lib.mkForce false;

  imports = [
    ./env.nix
    ./rules.nix
    ./exec.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./monitor.nix
    ./keymaps.nix
    ./swaync.nix
    ./plugins.nix

    ./rofi
    ./waybar
  ];

  home = {
    packages = with pkgs; [ cliphist grim slurp wl-clipboard swww ];
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
    profileExtra = # sh
      ''
        if uwsm check may-start; then
            exec uwsm start hyprland-uwsm.desktop
        fi
      '';
  };

}
