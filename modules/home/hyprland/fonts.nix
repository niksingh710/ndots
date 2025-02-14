{ pkgs, lib, ... }:
{
  home.shellAliases.font-family = "fc-list : family | ${lib.getExe pkgs.fzf}";
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-extra

    carlito
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
    pkgs.dejavu_fonts
  ] ++ (with pkgs.nerd-fonts; [
    jetbrains-mono
    fira-code
    droid-sans-mono
  ]);
}
