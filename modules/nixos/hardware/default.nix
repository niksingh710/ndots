{ lib, ... }: with lib;
{
  services.fwupd.enable = true;
  zramSwap = {
    enable = true;
    memoryPercent = 150;
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
