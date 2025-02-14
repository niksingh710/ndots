{ lib, config, ... }: with lib;
{
  options.ndots.hardware.opentabletdriver = mkEnableOption "OpenTabletDriver";
  config.hardware.opentabletdriver = {
    enable = config.ndots.hardware.opentabletdriver;
    daemon.enable = config.ndots.hardware.opentabletdriver;
  };
}
