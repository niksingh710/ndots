{ pkgs, ... }:
pkgs.mkShell {
  name = "dsa";
  buildInputs = [
    pkgs.python3
    pkgs.git
    pkgs.pyright
    pkgs.ruff
  ];

  shellHook = ''
    echo "Welcome to my Data Structures and Algorithms Environment"
  '';
}
