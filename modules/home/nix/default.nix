# Nix configurations for home-manager
{
  pkgs,
  inputs,
  opts,
  lib,
  ...
}:
with lib;
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      show-trace = true;
    };
    home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
    home.packages =
      with pkgs;
      [
        nixfmt-rfc-style
        nixpkgs-fmt
        nixd
        deadnix
        statix
        nurl

      ]
      ++ (with inputs.nsearch.packages.${pkgs.system}; [
        nsearch
        nrun
        nshell
      ]);
    programs = {
      # This tool will index all nix packages
      # `nix-locate` command will be available to find packages/libraries
      # `command-not-found` will be available in shell env
      nix-index.enable = true;
      nix-index-database.comma.enable = true;

      # This will allow to use the default shell in `nix develop` and `nix-shell`
      nix-your-shell.enable = true;

      nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 4d --keep 3";
        };
        flake = "/home/${opts.username}/flake";
      };
    };
  };
}
