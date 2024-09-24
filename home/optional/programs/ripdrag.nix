{ pkgs, lib, ... }: {
  home = {
    packages = [ pkgs.ripdrag ];
    shellAliases = {
      rdrag = "${lib.getExe pkgs.ripdrag} -s 128 -r -x -a -n -b";
    };
  };
}
