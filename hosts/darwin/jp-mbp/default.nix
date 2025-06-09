{
  pkgs,
  self,
  inputs,
  lib,
  opts,
  ...
}:
let
  inherit (opts) username;
  keyPath = "/Users/${username}/.config/sops/age/keys.txt";
in
with lib;
{

  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    )
    ++ (builtins.attrValues self.darwinModules);

  hm.imports = [
    self.homeModules.shell
    self.homeModules.editor
    self.homeModules.terminal
    self.homeModules.sops
    self.homeModules.programs
    self.homeModules.nix
    inputs.zen-nebula.homeModules.default
  ];
  hm.zen-nebula = {
    enable = true;
    profile = "default";
  };
  hm = {
    home.sessionVariables.SOPS_AGE_KEY_FILE = keyPath;
    ndots = {
      sops.enable = true;
      sops.keyFile = keyPath;
    };
  };

  hm.nvix.pkg = inputs.nvix.packages.${pkgs.system}.core.extend {
    nvix.explorer.neo-tree = false;
    nvix.explorer.oil = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        background.dark = "mocha";
        dim_inactive.enabled = true;
        transparent_background = true;
      };
    };
  };

  hm.programs = {
    git = {
      # use personal account not the companies one.
      enable = true;
      userName = lib.mkForce "niksingh710";
      userEmail = lib.mkForce "nik.singh710@gmail.com";
    };

  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.fastfetch
  ];

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
