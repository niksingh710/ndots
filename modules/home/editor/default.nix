{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = {

    # As Nvix overrides `vim` command, we need to disable it
    programs.vim.enable = mkForce false;

    home = {
      sessionVariables.EDITOR = "vim";
      packages = with config.nvix; [ pkg ];
    };
  };

  options = {
    nvix = {
      enable = mkEnableOption "Enabling nvix" // {
        default = true;
      };
      pkg = mkOption {
        type = types.package;
        # It should be a derivation
        default = inputs.nvix.packages.${pkgs.system}.bare;
      };
    };
  };
}
