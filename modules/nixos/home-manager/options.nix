{ lib, ... }: with lib;
{
  options.persist = {
    dir = mkOption {
      type = types.listOf (types.oneOf [ types.str types.attrs ]);
      default = [ ];
      description = "Persist directories";
    };
    files = mkOption {
      type = types.listOf (types.oneOf [ types.str types.attrs ]);
      default = [ ];
      description = "Persist files";
    };
  };
}
