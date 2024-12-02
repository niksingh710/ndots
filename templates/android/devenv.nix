{ pkgs, ... }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "android-env";
    targetPkgs = pkgs:
      with pkgs; [
        android-tools
        libxcrypt-legacy
        freetype
        fontconfig
        yaml-cpp

        bc
        binutils
        bison
        ccache
        curl
        flex
        gcc
        git
        git-repo
        git-lfs
        gnumake
        gnupg
        gperf
        imagemagick
        jdk11
        elfutils
        libxml2
        libxslt
        lz4
        lzop
        m4
        nettools
        openssl.dev
        perl
        pngcrush
        procps
        python3
        rsync
        schedtool
        SDL
        squashfsTools
        unzip
        util-linux
        xml2
        libcxx
        openssl
      ];
    multiPkgs = pkgs:
      with pkgs; [
        zlib
        ncurses5
        readline

        libgcc
        iconv
        iconv.dev
      ];
    runScript = "$SHELL";
  };
in
{
  env = {
    USE_CCACHE = 1;
    TMPDIR = "/tmp";
    ALLOW_NINJA_ENV = true;
    CCACHE_EXEC = "/usr/bin/ccache";
    ANDROID_JAVA_HOME = "${pkgs.jdk11.home}";
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.ncurses5}/lib";
  };

  packages = [
    fhs
  ];

  languages.python.enable = true;

  enterShell = ''
    alias python="python3"
    echo "Welcome to Android Crom dev env"
    echo "Run \`exec android-env\` to enter the environment"
  '';
}
