{ pkgs, ... }:
(builtins.getFlake
  "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5").packages.${pkgs.system}
