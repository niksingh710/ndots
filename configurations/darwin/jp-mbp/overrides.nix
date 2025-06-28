{ lib, config, pkgs, ... }:
with lib;
{
  # system level overrides for darwin

  nix.extraOptions = # conf
    ''
      !include ${config.hm.sops.secrets."private-keys/nix_access_token".path}
    '';

  hm.stylix.targets.fzf.enable = false;

  # home-manager level overrides as `hm` is aliased to `home-manager.users.${username}`.

  hm = {
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
  };
}
