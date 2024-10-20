{ inputs, pkgs, ... }:
let
  nrun = pkgs.writeShellApplication {
    name = "nrun";
    bashOptions = [ "pipefail" ];
    text = # bash
      ''
        pkgname="$1"
        shift  # Shift removes the first argument (pkgname) from the list of arguments

        args=("$@")

        cmd="nix run nixpkgs#$pkgname ''${args[*]}"
        echo "Executing \`$cmd\`..."

        # Execute the command
        eval "$cmd"

      '';
  };

  nshell = pkgs.writeShellApplication {
    name = "nshell";
    bashOptions = [ "pipefail" ];
    text =
      # bash
      ''
        # Initialize empty arrays for package names and options
        ps=()
        os=()
        in_nix_shell="pure"

        # Loop through all the arguments
        for p in "$@"; do
            if [[ "$p" != --* ]]; then
                # If not an option, add it to the package names array
                ps+=("nixpkgs#$p")
            else
                case "$p" in
                --pure) in_nix_shell="pure" ;;
                --impure) in_nix_shell="impure" ;;
                esac
                # If it is an option, add it to the options array
                os+=("$p")
            fi
        done

        # Construct the command
        cmd="SHELL=$SHELL IN_NIX_SHELL=\"$in_nix_shell\" nix shell ''${os[*]} ''${ps[*]}"
        echo "Executing \`$cmd\`..."

        # Execute the command
        eval "$cmd"
      '';
  };
in {
  persist.dir = [".cache/nsearch"];
  home.packages =
    [ inputs.nsearch.packages.${pkgs.system}.default nrun nshell ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    show-trace = true;
    system-features = [ "big-parallel" "kvm" "recursive-nix" ];
  };
}
