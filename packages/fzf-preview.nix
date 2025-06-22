{ pkgs, ... }:
(builtins.getFlake
  "github:niksingh710/fzf-preview/5d1d0930b80a310da5438141b8078916835156c0").packages.${pkgs.system}.default
