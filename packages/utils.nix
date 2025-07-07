{ pkgs, ... }:
(builtins.getFlake
  "github:niksingh710/utils/2b414fdcbdea34d25cb5d3e5f40c604b26c540c5").packages.${pkgs.system}
