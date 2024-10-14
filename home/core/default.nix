{
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  systemd.user.startServices = true;
  home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
}
