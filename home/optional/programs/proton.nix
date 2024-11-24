{ pkgs, ... }: {
  persist.dir = [ ".config/Proton" ".config/Proton Pass" ];
  home.packages = with pkgs; [ proton-pass ];
}
