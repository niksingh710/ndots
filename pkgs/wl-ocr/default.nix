{
  writeShellApplication,
  lib,
  grim,
  libnotify,
  slurp,
  tesseract5,
  wl-clipboard,
  langs ? "eng+hun+fra+jpn+jpn_vert+kor+kor_vert+pol+ron+spa+hin",
}:
with lib;
# Taken from <https://github.com/fufexan/dotfiles/tree/main/pkgs/wl-ocr/default.nix>

writeShellApplication {
  name = "wl-ocr";
  text = # sh
    ''
      ${getExe grim} -g "$(${getExe slurp})" -t ppm - \
      | ${getExe tesseract5} -l ${langs} - - \
      | ${getExe' wl-clipboard "wl-copy"}

      ${getExe' wl-clipboard "wl-paste"}

      ${getExe libnotify} -- "Copied Content:" "$(${getExe' wl-clipboard "wl-paste"})"
    '';
}
