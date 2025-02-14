{ lib, ... }: with lib;
{
  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));

  programs = {
    fd = {
      enable = true;
      hidden = true;
      extraOptions = [
        "--no-ignore"
        "--follow"
        "--absolute-path"
      ];
      ignores = [
        ".git/"
        "*.bak"
      ];
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };
  };
}
