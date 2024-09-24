{ pkgs, opts, inputs, ... }: {

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
      flake = "/home/${opts.username}/flake";
    };
    nix-ld.enable = true;
  };

  # execute shebangs that assume hardcoded shell paths
  services.envfs.enable = true;

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nixpkgs-fmt
    nixd
    deadnix
    statix
  ];

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      trusted-users = [ opts.username ];
      auto-optimise-store = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://anyrun.cachix.org"
        "https://fufexan.cachix.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };

    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [
      "nixpkgs=/etc/nixpkgs/channels/nixpkgs"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  systemd.tmpfiles.rules =
    [ "L+ /etc/nixpkgs/channels/nixpkgs - - - - ${pkgs.path}" ];

}
