{ lib, config, pkgs, ... }:
with lib;
let cfg = config.nmod.intel;
in {
  options.nmod.intel = {
    throttled = mkEnableOption "Throttled";
    pstate = mkEnableOption "Intel P-State";
    governer = mkOption {
      type = types.str;
      default = null;
      description = "CPU governer";
    };
  };

  config = {
    powerManagement = {
      powertop.enable = mkDefault true;
      cpuFreqGovernor = cfg.governer;
    };
    services.throttled.enable = cfg.throttled;
    boot.kernelParams = lib.optional (!cfg.pstate) "intel_pstate=disable"
      ++ [ "i915.enable_guc=2" ];

    hardware = {
      cpu.intel.updateMicrocode = mkDefault true;
      intel-gpu-tools.enable = mkDefault true;
      graphics = {
        enable = mkDefault true;
        enable32Bit = mkDefault true;
        extraPackages = with pkgs; [
          intel-vaapi-driver
          intel-media-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.driversi686Linux; [
          intel-vaapi-driver
          intel-media-driver
          libvdpau-va-gl
        ];
      };
    };

    environment = {
      variables = { VDPAU_DRIVER = lib.mkDefault "va_gl"; };
      systemPackages = with pkgs;
        [
          (writeShellApplication {
            name = "cpu";
            text = # bash
              ''
                arg="freq"
                [ $# -eq 1 ] && arg="$1"

                case $arg in
                  "freq")
                    watch -n1 -t "grep 'MHz' /proc/cpuinfo"
                    ;;
                  "temp")
                    watch -n1 -t "${
                      lib.getExe' pkgs.lm_sensors "sensors"
                    } | grep 'Core'"
                    ;;
                  "usage")
                    watch -n1 -t "${
                      lib.getExe' pkgs.sysstat "mpstat"
                    } -P ALL 1 1"
                    ;;
                  "turbo")
                    [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && echo "Turbo Boost: $(cat /sys/devices/system/cpu/intel_pstate/no_turbo)" || echo "Turbo Boost: no Pstate"
                    ;;
                  "governer")
                    echo "Governer: $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor)"
                    ;;
                  *)
                    echo "Usage: cpu [freq|temp|usage]"
                    ;;
                esac
              '';
          })
        ];
    };

  };
}
