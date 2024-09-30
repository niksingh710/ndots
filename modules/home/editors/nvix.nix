{ inputs, pkgs, config, lib, ... }:
with lib;
let
  cfg = config.nvix;
  nvix = inputs.nvix.packages.${pkgs.system}.default;
in
{
  options.nvix = {
    enable = mkEnableOption "Enabling nvix" // { default = true; };
    tex = mkEnableOption "tex";
  };

  config = mkIf cfg.enable {
    persist.dir = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
    home = {
      sessionVariables.EDITOR = "vim";
      packages = [ nvix ]
        ++ (with pkgs; [ nixd nixfmt-rfc-style deadnix statix ])
        ++ (lib.optionals cfg.tex [ pkgs.vimPlugins.ltex_extra-nvim ]);
    };
  };
}
