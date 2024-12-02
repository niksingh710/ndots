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

  config.persist = {
    dir = [
      "Downloads"
      "Pictures"
      "Documents"
      "Videos"
      "repos"
      "work"
      ".cache/zsh"
    ];
  };
}
