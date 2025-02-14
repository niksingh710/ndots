{ lib, ... }: with lib;
{

  options.ndots.hyprland.terminal = {
    foot = mkEnableOption "Enabling foot" // { default = true; };
  };

  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
