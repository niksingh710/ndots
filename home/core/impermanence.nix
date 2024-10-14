{ lib, ... }:
with lib; {
  options.persist = {
    dir = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    files = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
}
