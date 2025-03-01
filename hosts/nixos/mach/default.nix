{ inputs, pkgs, lib, self, config, ... }: with lib;
{
  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)))
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
    shellAliases.fetch = "${getExe pkgs.fastfetch} -c examples/10.jsonc";
    file."logo" = {
      source = pkgs.fetchurl {
        url = "https://techicons.dev/8f71c3a5-f0f3-40bb-8f98-a6755250c6b8";
        sha256 = "sha256-TKsB07l8HPxynAEIkLwDmWL61x+oTe2HRnRMpJbXiZg=";
      };
      target = "${config.hm.home.homeDirectory}/logo.png";
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
    plugins.snacks.settings.scroll.enabled = true;
    colorschemes.gruvbox = {
      enable = true;
      settings.transparent_mode = true;
    };
    colorscheme = mkForce "gruvbox";
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
    # TODO: enable when the cctools bug is fixed https://github.com/NixOS/nixpkgs/pull/356292
    enable = true;
    settings = {
      font = {
        normal = config.stylix.fonts.monospace;
        size = 10;
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
