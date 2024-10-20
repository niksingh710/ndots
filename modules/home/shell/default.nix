{ lib, ... }:
with lib; {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  programs = {
    nix-index.enable = mkDefault true;
    btop = {
      enable = mkDefault true;
      settings = {
        theme_background = mkForce false;
        vim_keys = true;
      };
    };
  };

}
