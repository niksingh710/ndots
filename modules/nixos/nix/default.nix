{ pkgs, inputs, self, opts, ... }: {

  nixpkgs.overlays = [ inputs.nix-alien.overlays.default ];
  environment.systemPackages = with pkgs;[ nix-alien ];
  nixpkgs.config.allowUnfree = true;
  # execute shebangs that assume hardcoded shell paths
  services.envfs.enable = true;
  programs.nix-ld.enable = true;
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ opts.username ];
      auto-optimise-store = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    registry.nixpkgs.flake = inputs.nixpkgs; # Syncs the flake with nixpkgs
    nixPath = [
      "nixpkgs=/etc/nixpkgs/channels/nixpkgs"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  systemd.tmpfiles.rules =
    [ "L+ /etc/nixpkgs/channels/nixpkgs - - - - ${pkgs.path}" ];

  hm.imports = [
    self.homeModules.nix
  ];
}
