{ pkgs, inputs, ... }:
let center-align = inputs.center-align.packages.${pkgs.system}.default;
in {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
  persist.dir = [
    ".local/share/applications"
    ".local/share/fractal"
    ".local/share/whatsapp-for-linux"
    ".local/share/onlyoffice"

    ".config/whatsapp-for-linux"
    ".config/onlyoffice"
  ];

  home.packages = with pkgs;
    [ fractal whatsapp-for-linux onlyoffice-bin_latest deluge nitch ]
    ++ [ center-align ];
}
