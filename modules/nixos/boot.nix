{ lib, inputs, config, pkgs, opts, ... }:
with lib;
let
  cfg = config.nmod.boot;
  center-align = inputs.center-align.packages.${pkgs.system}.default;
in {

  options.nmod.boot = {
    silent = mkEnableOption "silent boot" // { default = true; };
    plymouth = mkEnableOption "plymouth" // { default = true; };
    secure = mkEnableOption "secure boot";
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = mkMerge [
    {
      environment.etc."issue".source = pkgs.runCommand "issue" { } ''
        echo "${opts.username}" | ${lib.getExe' pkgs.figlet "figlet"} > $out
      '';
      boot.loader = {
        systemd-boot.enable = mkDefault true;
        efi.canTouchEfiVariables = mkDefault true;
      };
    }

    (mkIf cfg.silent {

      systemd.watchdog.rebootTime = "0s";

      boot = {
        consoleLogLevel = 0;
        initrd.verbose = !cfg.silent;
        loader = { timeout = 0; };
        kernelParams = [
          "quiet"
          "splash"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
          "nowatchdog"
        ];
      };
    })

    (mkIf cfg.plymouth {
      boot.plymouth.enable = true;
    })

    (mkIf cfg.secure {
      boot = {
        loader.systemd-boot.enable = false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })
  ];
}
