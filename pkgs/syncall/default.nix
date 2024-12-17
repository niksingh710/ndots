{ poetry2nix, syncall, python312, pkgs, ... }:
let
  p2n = poetry2nix.lib.mkPoetry2Nix { inherit pkgs; };
in
p2n.mkPoetryApplication {
  projectDir = syncall.outPath;

  postInstall = #sh
    ''
      if [ -d "$src/completions" ]; then
        mkdir -p $out/share/bash-completion/completions
        mkdir -p $out/share/zsh/site-functions
        mkdir -p $out/share/fish/vendor_completions.d
        # Install bash completions
        for file in "$src"/completions/bash/*.sh; do
          if [ -f "$file" ]; then
            # Extract the base filename without the `.sh` extension
            command_name=$(basename "$file" .sh)

            # Copy and rename the file to `_command_name`
            cp "$file" "$out/share/bash-completion/completions/$command_name"
          fi
        done

        for file in "$src"/completions/zsh/*.sh; do
          if [ -f "$file" ]; then
            # Extract the base filename without the `.sh` extension
            command_name=$(basename "$file" .sh)

            # Copy and rename the file to `_command_name`
            cp "$file" "$out/share/zsh/site-functions/_$command_name"
          fi
        done

        # Install fish completions
        if [ -d "$src/completions/fish" ]; then
          cp -r $src/completions/fish/* $out/share/fish/vendor_completions.d/
        fi
      fi
    '';

  python = python312;
  preferWheels = true;
}
