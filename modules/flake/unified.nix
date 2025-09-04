{ inputs, self, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
    (inputs.git-hooks + /flake-module.nix)
    ../../packages
  ];
  debug = true;
  perSystem = { self', lib, system, pkgs, config, ... }: {

    # Make our overlay available to the devShell
    # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
    # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = lib.attrValues self.overlays;
      config.allowUnfree = true;
    };

    packages.default =
      let
        activateBin = lib.getExe self'.packages.activate;
      in
      pkgs.writeShellApplication {
        name = "ndots-apply";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          case "$(uname -s)" in
              Linux)
                  if [ -f /etc/NIXOS ]; then
                      exec nh os switch . "$@"
                  else
                      # Not NixOS but Linux → run activate package
                      exec ${activateBin} "$@"
                  fi
                  ;;
              Darwin)
                  exec nh darwin switch . -H "$(${lib.getExe pkgs.hostname})" "$@"
                  ;;
              *)
                  # Other OS (e.g. BSD, WSL, etc.)
                  exec ${activateBin} "$@"
                  ;;
          esac
        '';
      };

    packages.clean = pkgs.writeShellApplication {
      name = "ndots-clean";
      runtimeInputs = [ pkgs.nh ];
      text = ''
        nh clean all
      '';
    };


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
      hooks.nixpkgs-fmt.enable = true;
    };
  };
}
