{
  description = "Flake Containing Env Custom rom development";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "android-croms";
          buildInputs = with pkgs;[
            python3
            git
            git-repo
            curl
            gh

            android-tools
            autoconf
            automake
            axel
            bc
            bison
            ccache
            clang
            cmake
            curl
            expat
            flex
            gcc
            gawk
            git
            git-lfs
            gnupg
            gperf
            htop
            imagemagick
            ncurses5.dev
            libcap
            maven
            ncftp
            ncurses
            patch
            patchelf
            pkg-config
            pngcrush
            pngquant
            python3Packages.pyelftools
            re2c
            schedtool
            subversion
            texinfo
            unzip
            w3m
            zip
            zlib
            lzip
            perlPackages.XMLSimple
            perlPackages.Switch
            rsync
          ];

          shellHook = ''
            alias python="python3"
            echo "Welcome to Android Crom dev env"
          '';
        };
      };
    };
}
