{ inputs, pkgs, ... }: {
  home.packages = [ inputs.nsearch.packages.${pkgs.system}.default ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    show-trace = true;
    system-features = [ "big-parallel" "kvm" "recursive-nix" ];
  };
}
