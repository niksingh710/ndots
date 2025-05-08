{ pkgs, ... }:
let
  libraries =
    with pkgs;
    lib.makeLibraryPath [
      libffi
      openssl
      stdenv.cc.cc
      taglib
      openssl
      git
      libxml2
      libxslt
      libzip
      zlib
      libGL
      glib
      # If you want to use CUDA, you should uncomment this line.
      # linuxPackages.nvidia_x11
    ];
in
pkgs.mkShell {
  name = "nix-python-venv";

  venvDir = "./.venv";
  buildInputs =
    with pkgs;
    [
      # In this particular example, in order to compile any binary extensions they may
      # require, the Python modules listed in the hypothetical requirements.txt need
      # the following packages to be installed locally:
      clang
      taglib
      openssl
      git
      libxml2
      libxslt
      libzip
      zlib
      readline
      libffi
      openssl
      pyright
      ruff
    ]
    ++ (with pkgs.python3Packages; [
      # A Python interpreter including the 'venv' module is required to bootstrap
      # the environment.
      pip
      setuptools
      venvShellHook
      wheel
    ]);

  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -r requirements.txt
  '';

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH

    # Allow the use of wheels.
    SOURCE_DATE_EPOCH=$(date +%s)
    # Augment the dynamic linker path
    export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${libraries}"
  '';
}
