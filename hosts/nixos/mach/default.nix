{
  inputs,
  pkgs,
  lib,
  self,
  config,
  ...
}:
with lib;
{
  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    )
    ++ (builtins.attrValues self.nixosModules)
    ++ [
      ../impermanence.nix # to make common dir permanent
    ];

  hm.imports = [
    self.homeModules.editor
    self.homeModules.browsers
    self.homeModules.utils
    self.homeModules.sops
    self.homeModules.nixos
    self.homeModules.programs
  ];

  hm.ndots = {
    # only enable sops after the installation of the system
    sops.enable = true; # to enable sops services and config
    hyprland.terminal = {
      foot = false;
      kitty = true;
    };
  };

  hm.home = {
    shellAliases.fetch = "${getExe pkgs.fastfetch} -c examples/17.jsonc --kitty-icat $HOME/.logo.png --logo-width 25 --logo-padding-right 3";
    file."logo" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg";
        sha256 = "e37b5a1c11e81496e9d46af04908951ada6babaa416d670aaae4934cce912eb2";
      };
      target = "${config.hm.home.homeDirectory}/.logo.png";
    };
  };

  ndots = {
    sec.askPass = false;
    disk.device = "/dev/nvme0n1";
    hardware.opentabletdriver = true;
    disk.impermanence = true;
    disk.encrypted = true;
    networking.firewall = true;
    networking.stevenblack = true;
    networking.ssh = false;
    boot.secureboot = true;
    networking.timezone = "Asia/Kolkata";
  };

  hm.nvix.pkg = inputs.nvix.packages.${pkgs.system}.full.extend {
    nvix.explorer.neo-tree = false;
    nvix.explorer.oil = true;
    # colorschemes.gruvbox = {
    #   enable = true;
    #   settings.transparent_mode = true;
    # };
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        background.dark = "mocha";
        dim_inactive.enabled = true;
        transparent_background = true;
      };
    };

    colorscheme = mkForce "catppuccin-mocha";
    extraConfigLuaPre = # lua
      ''
        if vim.g.neovide then
          vim.g.neovide_transparency = ${builtins.toString config.stylix.opacity.popups}
          vim.cmd([[highlight Normal guibg=#${config.lib.stylix.colors.base00}]])
        end
      '';
  };

  hm.home.shellAliases = {
    gvim = "setsid neovide $@ &>/dev/null";
  };

  hm.programs.neovide = {
    enable = true;
    settings = {
      font = {
        normal = config.stylix.fonts.monospace;
        size = 10;
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
