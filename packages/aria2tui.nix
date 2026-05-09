{
  lib,
  python3Packages,
  fetchFromGitHub,
  fetchPypi,
}:

let
  listpick = python3Packages.buildPythonPackage rec {
    pname = "listpick";
    version = "0.1.18.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1bxihapgzwc9aslvgkgp4615klii8nn0i69xk5sl9964jsgvhgny";
    };

    pyproject = true;
    build-system = with python3Packages; [ setuptools ];
    nativeBuildInputs = with python3Packages; [ setuptools ];
    propagatedBuildInputs = with python3Packages; [
      wcwidth
      pyperclip
      toml
      dill
    ];

    pythonImportsCheck = [ "listpick" ];

    meta = with lib; {
      description = "TUI picker for Python";
      homepage = "https://github.com/grimandgreedy/listpick";
      license = licenses.mit;
    };
  };
in
python3Packages.buildPythonApplication rec {
  pname = "aria2tui";
  version = "0.1.13.1";

  src = fetchFromGitHub {
    owner = "grimandgreedy";
    repo = "aria2tui";
    rev = "v${version}";
    hash = "sha256-GskyV9ArQv/UfLlOZ4q/M10QpNKvOXYL6QpNXt3BgHQ=";
  };

  pyproject = true;
  build-system = with python3Packages; [ setuptools ];

  propagatedBuildInputs =
    with python3Packages;
    [
      plotille
      requests
      tabulate
      toml
      numpy
    ]
    ++ [
      listpick
    ];

  nativeBuildInputs = with python3Packages; [
    setuptools
  ];

  # Copy config file to correct location
  postInstall = ''
    mkdir -p $out/share/aria2tui
    cp src/aria2tui/data/config.toml $out/share/aria2tui/
  '';

  pythonImportsCheck = [ "aria2tui" ];

  meta = with lib; {
    description = "A TUI Frontend for the Aria2c Download Manager";
    homepage = "https://github.com/grimandgreedy/aria2tui";
    license = licenses.mit;
    platforms = platforms.unix;
    mainProgram = "aria2tui";
  };
}
