{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay.url = "github:oxalica/rust-overlay";
    systems.url = "github:nix-systems/default";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      rust-overlay,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        inputs.git-hooks-nix.flakeModule
      ];
      perSystem =
        { system, config, ... }:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs { inherit system overlays; };
        in
        {

          pre-commit.settings.hooks = {
            nixfmt-rfc-style.enable = true;

            rustfmt.enable = true;
            cargo-check.enable = true;
            clippy = {
              enable = true;
              settings.allFeatures = true;
            };
          };

          devShells.default = pkgs.mkShell {
            name = "rust-dev";
            buildInputs = with pkgs; [
              (rust-bin.stable.latest.default.override {
                extensions = [
                  "rust-src"
                  "rust-analyzer"
                ];
              })
              cargo
              rustfmt
              clippy

              # nix
              git
              nixd
              nixfmt-rfc-style
            ];

            shellHook = ''
              ${config.pre-commit.installationScript}
              echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
              echo 1>&2 "Ready to work on Rust!"
              export RUST_BACKTRACE=1
            '';
          };
        };
    };
}
