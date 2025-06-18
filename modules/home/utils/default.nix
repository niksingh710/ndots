{
  pkgs,
  inputs,
  self,
  ...
}:
let
  utils = inputs.utils.packages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    figlet
    file
    zip
    unzip
    unrar
    killall
    wget
    jq
    duf
    poppler_utils
    pdftk
    # (pkgs.callPackage "${self}/pkgs/syncall" { inherit (inputs) poetry2nix syncall; })
    utils.myip
    utils.cat
  ];

  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };
  home = {
    shellAliases = {
      gt = "task +gtasks";
      gts = "tw_gtasks_sync -l 'My Tasks' -t gtasks";
    };
  };
}
