{ lib, inputs, config, ... }:
with lib;
let cfg = config.nmod.boot;
in {

  options.nmod.boot = {
    silent = mkEnableOption "silent boot" // { default = true; };
    plymouth = mkEnableOption "plymouth" // { default = true; };
    secure = mkEnableOption "secure boot";
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = mkMerge [
    {
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
      boot.initrd.systemd.enable = true;
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
