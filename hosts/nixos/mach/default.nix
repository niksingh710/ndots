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
      ../impermanence.nix # to make common dir permanenet
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
    shellAliases.fetch = "${getExe pkgs.fastfetch} -c examples/10.jsonc --kitty-icat $HOME/.logo.png --logo-padding-top 10 ";
    file."logo" = {
      source = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/NixOS_logo.svg/320px-NixOS_logo.svg.png";
        sha256 = "3d80fa904f55fd7adb6a11c327b0db42aa1f22205af4e8b852dbc466a30f3ff5";
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
