{ pkgs, ... }: {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
  persist.dir = [ 
    ".local/share/applications" 
    ".local/share/fractal" 
    ".local/share/whatsapp-for-linux" 
    ".local/share/onlyoffice" 

    ".config/dissent" 
    ".config/onlyoffice" 
  ];
  home.packages = with pkgs; [
    dissent
    fractal
    whatsapp-for-linux
    onlyoffice-bin_latest
  ];
}
