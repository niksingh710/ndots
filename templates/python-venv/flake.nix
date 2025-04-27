{
  description = "Quick python venv setup";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "nix-python-venv";
            venvDir = "./.venv";
            buildInputs =
              with pkgs;
              [
                # In this particular example, in order to compile any binary extensions they may
                # require, the Python modules listed in the hypothetical requirements.txt need
                # the following packages to be installed locally:
                taglib
                openssl
                git
                libxml2
                libxslt
                libzip
                zlib
              ]
              ++ (with pkgs.python3Packages; [
                # A Python interpreter including the 'venv' module is required to bootstrap
                # the environment.
                python3Packages.python

                # This executes some shell code to initialize a venv in $venvDir before
                # dropping into the shell
                python3Packages.venvShellHook

                # Those are dependencies that we would like to use from nixpkgs, which will
                # add them to PYTHONPATH and thus make them accessible from within the venv.
                python3Packages.numpy
                python3Packages.pandas
                python3Packages.statsmodels
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
            '';

          };
        };
    };
}
