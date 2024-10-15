{ inputs, pkgs, lib, self, ... }: {
  nixpkgs.overlays = [

    (next: prev: {
      stable = import inputs.nixpkgs-stable {
        # This allows me to use `pkgs.stable`
        inherit (pkgs) system;
        config.allowUnfree = true;
      };

      # TODO: revert to unstable when it's fixed
      cliphist = next.stable.cliphist;

      intel-vaapi-driver =
        prev.intel-vaapi-driver.override { enableHybridCodec = true; };

      lib = import ./lib.nix {
        inherit (prev) pkgs;
        inherit lib;
      };

      nvix = inputs.nvix.packages.${pkgs.system}.full.extend {
        config.colorschemes.tokyonight.settings.transparent = true;
      };

      nvix-bare = inputs.nvix.packages.${pkgs.system}.bare;

      custom = self.packages.${prev.system};

      wmhypr = inputs.hyprland.inputs.nixpkgs.legacyPackages.${prev.system};

      rofi-calc = prev.rofi-calc.override {
        rofi-unwrapped = prev.rofi-wayland-unwrapped;
      };

      google-chrome = prev.google-chrome.overrideAttrs {
        enableWidevine = true;
        enableFlash = true;
      };

      rofimoji = prev.rofimoji.override { rofi = prev.rofi-wayland; };

      mpv = prev.mpv.override {
        scripts = with pkgs.mpvScripts; [ modernx-zydezu thumbfast ];
      };

    })
  ];
}
