{
  description = "The Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-wire.url = "github:niksingh710/nix-wire";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # hooks for git
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.flake = false;

    # mac-app solution (linking to launcher and finder)
    mac-app-util.url = "github:hraban/mac-app-util";

    # sops-nix for managing secrets
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # flox (The wrapper around nixpkgs | All in one)
    flox.url = "github:flox/flox/latest";

    # stylix for themeing
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # disk management for nixos installations/configurations
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Discord flake
    nixcord.url = "github:kaylorben/nixcord";

    # nix-index; `,` command available
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # zen till (https://github.com/NixOS/nixpkgs/issues/327982) is resolved.
    # will be resolved once zen comes out of beta.
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # personal flakes
    nsearch.url = "github:niksingh710/nsearch";
    nvix.url = "github:niksingh710/nvix";
  };

  outputs =
    inputs:
    inputs.nix-wire.mkFlake {
      inherit inputs;
      imports = [ ./parts ];
    };
}
