{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells = {

        dsa = import ./dsa.nix { inherit pkgs; };
        python-venv = import ../templates/python-venv/default.nix { inherit pkgs; };

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
            nixfmt-rfc-style
            nh
          ];
          shellHook = ''
            ${config.pre-commit.installationScript}
            echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
            echo 1>&2 "Ready to work on ndots!"
          '';
        };
      };
    };
}
