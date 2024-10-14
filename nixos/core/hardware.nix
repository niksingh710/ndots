{ lib, opts, config, pkgs, ... }:
with lib;
let cfg = config.nmod.hardware;
in {
  options.nmod.hardware = { ddc = mkEnableOption "ddc"; };
  config = mkMerge [
    (mkIf cfg.ddc {
      environment.systemPackages = with pkgs;
        [
          (writeShellApplication {
            name = "dbrig";
            bashOptions = [ "pipefail" ];
            runtimeInputs = with pkgs;[ ddcutil ];
            text = # bash
              ''
                # Check if an argument is provided
                if [ "$#" -ne 1 ]; then
                  echo "Usage: $0 [+|-]value"
                  exit 1
                fi

                # Get the current brightness value
                current_brightness=$(sudo ddcutil getvcp 10 | grep -oP '(?<=\=)\s*\d+' | head -n1 | tr -d ' ')

                # Parse the input argument
                operation="''${1:0:1}"
                value="''${1:1}"

                # Ensure the value is a number
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                  echo "Value must be a number."
                  exit 1
                fi

                # Calculate new brightness based on operation
                if [[ "$operation" == "+" ]]; then
                  new_brightness=$((current_brightness + value))
                elif [[ "$operation" == "-" ]]; then
                  new_brightness=$((current_brightness - value))
                else
                  echo "Invalid operation. Use + or -."
                  exit 1
                fi

                # Ensure new brightness is within valid range (0-100)
                if [ "$new_brightness" -lt 0 ]; then
                  new_brightness=0
                elif [ "$new_brightness" -gt 100 ]; then
                  new_brightness=100
                fi

                # Set the new brightness
                ddcutil setvcp 10 $new_brightness

                echo "Brightness adjusted to: $new_brightness"
              '';
          })
        ];
      boot = {
        initrd.services.udev.rules = ''
          SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", ATTRS{class}=="0x030000", TAG+="uaccess"
          SUBSYSTEM=="dri", KERNEL=="card[0-9]*", TAG+="uaccess"
        '';
      };

      users = {
        groups."i2c" = { };
        users.${opts.username}.extraGroups = [ "i2c" ];
      };
      boot.kernelModules = [ "i2c-dev" ];
    })
  ];
}
