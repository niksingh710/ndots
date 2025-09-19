{
  programs.eza = {
    enable = true;
    colors = "auto";
    git = true;
    icons = "auto";
    extraOptions = [
      "--group"
      "--header"
      "--smart-group"
      "--classify=auto"
      "--group-directories-first"
    ];
  };
  home.shellAliases = rec {
    ls = "eza -s modified --reverse";
    lt = "${ls} --tree";
    tree = "${lt}";
  };
}
