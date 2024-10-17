{ pkgs, ... }: {
  imports = with builtins;
    map (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  
  environment.sessionVariables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    fuse
    exfat
    exfatprogs
    ntfs3g
    usbutils
    xdg-utils
  ];
}
