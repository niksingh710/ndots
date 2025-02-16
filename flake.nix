{
  description = "My Personal NixOS Configuration";
  outputs = inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./iso # custom iso builds for me

        ./modules # custom modules for me

        # all possible hosts configurations
        # - standalone home-manager configs
        # - nixOs config for NixOS
        # - darwin config for macOS
        ./hosts

        # shell instances to test configurations
        ./devshells

        # My custom overlays
        ./overlays
      ];
      flake.templates = import ./templates;
      flake.disko = import ./disko;

      systems = import inputs.systems;
      perSystem = { pkgs, ... }: {
        packages = import ./pkgs { inherit pkgs; }; # Packaged by me accessible to anyone
      };
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixcord.url = "github:kaylorben/nixcord";

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My neovim config based on Nixvim
    nvix.url = "github:niksingh710/nvix";
    fzf-preview.url = "github:niksingh710/fzf-preview";

    impermanence.url = "github:nix-community/impermanence";

    textfox.url = "github:adriankarlen/textfox";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils = {
      url = "github:niksingh710/utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mailspring-theme = {
      url = "github:jpminor/mailspring-isaac-dark-theme";
      flake = false;
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Custom hyprland scripts
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for taskwarrior HACK: Fix it
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    syncall = {
      url = "github:bergercookie/syncall";
      flake = false;
    };

    # For secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Tmux Plugin for minimal status line
    # TODO: Make it available to nixpkgs by default
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-sessionx = {
      url = "github:omerxx/tmux-sessionx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
