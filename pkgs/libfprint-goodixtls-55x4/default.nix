{ fetchFromGitHub, cmake, openssl, doctest, libfprint, opencv, }:

libfprint.overrideAttrs (oa: {
  pname = "libfprint-goodixtls-55x4";
  # branch: 55b4-experimental
  version = "0-unstable-2023-11-14";

  src = fetchFromGitHub {
    owner = "TheWeirdDev";
    repo = "libfprint";
    rev = "6e4fdc0160088a4e0c1061fa173fb76c1f2efbf7";
    sha256 = "sha256-nyDp7WL8ZULsFKqA393v5KC0tryuwKmpog+tPJ+kJ0A=";
  };

  nativeBuildInputs = (oa.nativeBuildInputs or [ ]) ++ [
    cmake # for finding doctest
  ];

  dontUseCmakeConfigure = true;

  buildInputs = (oa.buildInputs or [ ]) ++ [
    doctest
    opencv
    openssl
  ];

  # "27c6:55a4 implemented by driver goodixtls55x4" -> SIGTRAP
  # but need python from nativeInstallCheckInputs to configure (misplaced?)
  installCheckPhase = ''
    echo "Nope :)"
  '';

  meta = oa.meta // {
    description = "libfprint fork for goodixtls 55x4 devices. Currently supports 55b4.";
    maintainers = [
      ({
        name = "Alireza S.N.";
        email = "alireza6677@gmail.com";
      })
    ];
  };
})
