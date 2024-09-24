{ pkgs, ... }: {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  environment.systemPackages = with pkgs; [
    fuse
    exfat
    exfatprogs
    ntfs3g
    usbutils
    xdg-utils
  ];
}
