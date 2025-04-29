{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells = {
        # This can be used if wanna use devShell from git-hooks flake
        # default = config.pre-commit.devShell.overrideAttrs (oa: {
        #   name = "ndots";
        #   packages =
        #     oa.packages
        #     ++ (with pkgs; [
        #       nixpkgs-fmt
        #       nix-darwin
        #       nh
        #     ]);
        # });

        default = pkgs.mkShell {
          name = "ndots";
          packages = with pkgs; [
            nixd
            nixpkgs-fmt
            nh
          ];
          shellHook = ''
            ${config.pre-commit.installationScript}
            echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
            echo 1>&2 "Ready to work on ndots!"
          '';
        };

        dsa = import ./dsa.nix { inherit pkgs; };
        python-venv = import ./python-venv.nix { inherit pkgs; };
      };
    };
}
