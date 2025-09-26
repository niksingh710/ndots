{ inputs, ... }:
{
  imports = [
    (inputs.git-hooks + /flake-module.nix)
  ];

  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "ndots";
        meta.description = "Dev environment for nixos-config";
        inputsFrom = [ config.pre-commit.devShell ];
        packages = with pkgs; [
          just
        ];
        shellHook = ''
          echo 1>&2 "🐼: $(id -un) | 🧬: $(nix eval --raw --impure --expr 'builtins.currentSystem') | 🐧: $(uname -r) "
          echo 1>&2 "Ready to work on ndots!"
        '';
      };

      pre-commit.settings = {
        hooks.nixfmt-rfc-style.enable = true;
      };
    };
}
