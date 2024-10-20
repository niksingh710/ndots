{ pkgs, inputs, ... }:
let center-align = inputs.center-align.packages.${pkgs.system}.default;
in {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
  persist.dir = [
    ".local/share/fractal"
    ".local/share/onlyoffice"

    ".config/dissent"
    ".config/onlyoffice"
  ];

  home.packages = with pkgs;
    [ dissent fractal onlyoffice-bin_latest deluge ]
    ++ [ center-align ];
}
