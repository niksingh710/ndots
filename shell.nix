{ pkgs ? import <nixpkgs> { } }: pkgs.mkShell {
  packages = [
    pkgs.nodejs
  ];

  shellHook = ''zsh'';
}
