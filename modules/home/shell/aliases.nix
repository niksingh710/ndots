{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  utils = inputs.utils.packages.${pkgs.system};
in
{
  # Most of the aliases are associated with the respective program files.
  # Still here are a few that i like to have on my shell.

  home = {
    shellAliases = {
      c = "clear";
      isodate = ''date -u "+%Y-%m-%dT%H:%M:%SZ"'';

      mkdir = "printf '\\033[1;33m' && mkdir -pv";
      cp = "printf '\\033[1;32m' && cp -rv";
      rcp = "printf '\\033[1;32m' && rsync -r --info=progress2,stats2 --outbuf=L";
      rm = "printf '\\033[1;31m' && rm -rIv";

      d = "setsid $@ &>/dev/null";
    };

    packages = [
      utils.myip
      utils.cat
      (pkgs.writeShellScriptBin "help" "$@ --help 2>&1 | ${lib.getExe pkgs.bat} --plain --language=help")
    ];
  };
}
