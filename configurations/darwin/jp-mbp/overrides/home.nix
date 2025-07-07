{ lib, pkgs, config, ... }:
with lib;
{
  stylix.targets.fzf.enable = false;
  sops.secrets."private-keys/nix_access_token" = { };
  programs.kitty = {
    font.size = mkForce 16;
    settings.background_opacity = mkForce 0;
  };
  services.jankyborders.settings.active_color = "0xff${config.lib.stylix.colors.base06}";
  # programs.tmux.plugins = [
  #   {
  #     plugin = pkgs.emptyDirectory; # FIXME: As soon as PR <https://github.com/NixOS/nixpkgs/pull/420215> is merged.
  #     extraConfig = ''
  #       set -g @minimal-tmux-bg "#${config.lib.stylix.colors.base01}"
  #       set -g @minimal-tmux-bg "#${config.lib.stylix.colors.base06}"
  #       set -g @minimal-tmux-use-arrow true
  #       set -g @minimal-tmux-right-arrow ""
  #       set -g @minimal-tmux-left-arrow ""
  #     '';
  #   }
  # ];


  # Telegram theming via stylix, using walogram package
  home.activation.tg-theme = lib.hm.dag.entryAfter [ "" ] ''
    run ${lib.getExe (pkgs.utils.walogram.override {
      image = "${config.stylix.image}";
      colors = (
        with config.lib.stylix.colors;
        ''
          color0="#${base00}"
          color1="#${base01}"
          color2="#${base02}"
          color3="#${base03}"
          color4="#${base04}"
          color5="#${base05}"
          color6="#${base06}"
          color7="#${base07}"
          color8="#${base08}"
          color9="#${base09}"
          color10="#${base0A}"
          color11="#${base0B}"
          color12="#${base0C}"
          color13="#${base0D}"
          color14="#${base0E}"
          color15="#${base0F}"
        '');
      })}
  '';
}
