{ pkgs, ... }: {
  persist.dir = [ ".config/geary" ".local/share/geary" ];
  home.packages = with pkgs; [ geary ];
}