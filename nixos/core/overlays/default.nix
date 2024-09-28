{ inputs, pkgs, lib, self, ... }: {
  nixpkgs.overlays = [

    (_: prev: {
      stable = import inputs.nixpkgs-stable {
        # This allows me to use `pkgs.stable`
        inherit (pkgs) system;
        config.allowUnfree = true;
      };

      intel-vaapi-driver =
        prev.intel-vaapi-driver.override { enableHybridCodec = true; };

      lib = import ./lib.nix {
        inherit (prev) pkgs;
        inherit lib;
      };

      # include custom packages lib fn's
      # custom = (prev.custom or { })
      #   // (import ./pkgs { inherit (prev) pkgs; });
      custom = self.packages.${prev.system};

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
