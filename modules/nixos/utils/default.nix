{ pkgs, lib, ... }: with lib;
{
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
    seahorse
  ];

  services.udisks2.enable = true;

  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
