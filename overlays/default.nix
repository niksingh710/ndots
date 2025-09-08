{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
final: prev: {
  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    inherit (prev) system;
    overlays = prev.lib.attrValues self.overlays;
  };
  nixpkgs = prev.callPackage "${packages}/nix-search-tv-script.nix" { };
  utils = prev.callPackage "${packages}/utils.nix" { };
  stremio-enhanced = prev.callPackage "${packages}/stremio-enhanced.nix" { };
  nvix = inputs.nvix.packages.${prev.system}.core.extend {
    config = {
      vimAlias = true;
      colorschemes = {
        catppuccin = {
          enable = true;
          settings = {
            background.dark = "mocha";
            transparent_background = true;
            color_overrides.all = {
              base = "#000000";
              mantle = "#000000";
              crust = "#000000";
            };
          };
        };
      };
    };
  };
}
