{ pkgs, ... }: {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  home.packages = with pkgs; [
    dissent
    proton-pass
    fractal
    whatsapp-for-linux
    onlyoffice-bin_latest
  ];
}
