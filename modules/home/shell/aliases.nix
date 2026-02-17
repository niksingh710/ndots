{ pkgs, lib, ... }:
{
  home = {
    shellAliases = {
      c = "clear";
      d = "setsid $@ &>/dev/null"; # run command in background
      cp = "printf '\\033[1;32m' && cp -rv";
      rm = "printf '\\033[1;31m' && rm -rIv";
      rcp = "printf '\\033[1;32m' && rsync -r --info=progress2,stats2 --outbuf=L";
      mkdir = "printf '\\033[1;33m' && mkdir -pv";
      isodate = ''date -u "+%Y-%m-%dT%H:%M:%SZ"'';
      matrix = "${lib.getExe pkgs.unimatrix} -f -l ocCgGkS -s 96 2&> /dev/null";
    };

    packages = [
      (pkgs.writeShellScriptBin "help" "$@ --help 2>&1 | ${lib.getExe pkgs.bat} --plain --language=help")
    ];
  };
}
