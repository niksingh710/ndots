{ pkgs, ... }:
{
  env.GREET = ''
    Welcome!
    Are You Ready to complete the Dissertation work?
  '';

  packages = with pkgs; [
    biber
    pandoc
    git
    zathura
  ];

  languages.texlive = {
    enable = true;
    base = pkgs.texliveFull;
    packages = [
      "algorithms"
      "latexmk"
      "scheme-full"
      "pgf"
      "pgfplots"
      "picture"
      "collection-pictures"
    ];
  };

  enterShell = ''
    export EDITOR=vim   # Replace with your preferred editor
    export PDF_VIEWER=zathura
    echo $GREET
  '';
}
