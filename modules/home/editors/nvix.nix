{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.nvix;
in
{
  options.nvix = {
    enable = mkEnableOption "Enabling nvix" // { default = true; };
    pkg = mkOption {
      type = types.package;
      default = pkgs.nvix;
    };
  };

  # packages are coming from the overlay
  config = mkIf cfg.enable {
    persist.dir = [ ".local/share/nvim" ".local/state/nvim" ".config/github-copilot" ];
    home = {
      sessionVariables.EDITOR = "vim";
      packages = [ cfg.pkg ];
    };
  };
}
