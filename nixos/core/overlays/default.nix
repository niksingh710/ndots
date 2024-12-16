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

      figlet = prev.figlet.overrideAttrs (oa: rec {
        contributed = pkgs.fetchFromGitHub {
          owner = "xero";
          repo = "figlet-fonts";
          rev = "a6d2db1a3ee88bec3518214e851825fc4495ac84";
          hash = "sha256-dAs7N66D2Fpy4/UB5Za1r2qb1iSAJR6TMmau1asxgtY";
        };
        postInstall = "cp -ar ${contributed}/* $out/share/figlet/";
        meta.mainProgram = "figlet";
      });

      intel-vaapi-driver =
        prev.intel-vaapi-driver.override { enableHybridCodec = true; };

      lib = import ./lib.nix {
        inherit (prev) pkgs;
        inherit lib;
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
