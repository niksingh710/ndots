{
  description = "Flake Containing Env for my Data Structures and Algorithms";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvix.url = "github:niksingh710/nvix";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "dsa";
          buildInputs = [
            pkgs.python3
            pkgs.git

            # My Editor
            inputs.nvix.packages.${pkgs.system}.base

            # Python formatter and linter for my editor
            pkgs.pyright
            pkgs.ruff
          ];

          shellHook = ''
            echo "Welcome to my Data Structures and Algorithms Environment"
          '';
        };
      };
    };
}
