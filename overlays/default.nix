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
  # TODO: remove once <https://github.com/NixOS/nixpkgs/pull/423701> is merged
  choose-gui = prev.choose-gui.overrideAttrs {
    src = prev.fetchFromGitHub {
      owner = "chipsenkbeil";
      repo = "choose";
      rev = "1.5.0";
      hash = "sha256-ewXZpP3XmOuV/MA3fK4BwZnNb2jkE727Sse6oAd4HJk=";
    };
  };
  nvix = inputs.nvix.packages.${prev.system}.core.extend {
    config = {
      vimAlias = true;
      colorschemes = {
        catppuccin.enable = prev.lib.mkForce false;
        gruvbox-material = {
          enable = true;
          settings = {
            contrast = "hard";
            background.transparent = true;
          };
        };
      };
    };
  };
}
