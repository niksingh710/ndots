{ pkgs, inputs, ... }: {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  home.packages = with pkgs;
    let bstat = inputs.bstat.packages.${pkgs.system}.default;
    in [ zip unzip unrar killall libnotify wget jq bstat ];
  xdg.mimeApps.enable = true;
}
