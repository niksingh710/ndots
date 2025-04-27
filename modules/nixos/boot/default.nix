{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.ndots.boot;
in
{
  options.ndots.boot = {
    silent = mkEnableOption "Silent boot?" // {
      default = true;
    };
    plymouth = mkEnableOption "plymouth" // {
      default = true;
    };
    secureboot = mkEnableOption "secureboot";
  };

  config = mkMerge [
    {
      environment.etc."issue".source =
        pkgs.runCommand "issue" { } # bash
          ''
            echo "Welcome, ${opts.username}" > $out
          '';

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    }

    (mkIf cfg.plymouth {
      boot.plymouth.enable = true;
    })

    (mkIf cfg.silent {
      systemd.watchdog.rebootTime = "0s";
      boot = {
        consoleLogLevel = 0;
        initrd.verbose = !cfg.silent;
        loader = {
          timeout = 0;
        };
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

    (mkIf cfg.secureboot {
      boot = {
        loader.systemd-boot.enable = mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })
  ];

  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    )
    ++ [ inputs.lanzaboote.nixosModules.lanzaboote ];

}
