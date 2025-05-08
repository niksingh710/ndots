{
  description = "change-me: <Cleaner flake parts template>";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        # For shell env and commits
        inputs.git-hooks-nix.flakeModule
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          packages.default = pkgs.hello;

          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
          default = pkgs.mkShell {
            name = "{{template}}";
            packages = with pkgs; [
              nixd
              nixfmt-rfc-style
              git
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}
              echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
              echo 1>&2 "Ready to work on {{template}}!"
            '';
          };
        };
      flake = { };
    };
}
