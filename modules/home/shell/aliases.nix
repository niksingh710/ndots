{ lib, pkgs, ... }: {
  programs = {
    bat = {
      enable = true;
      extraPackages = [
        (pkgs.bat-extras.batman.overrideAttrs (o: {
          postInstall = (o.postInstall or "") + # bash
            ''
              mkdir -p $out/share/bash-completion/completions
              echo 'complete -F _comp_cmd_man batman' > $out/share/bash-completion/completions/batman

              mkdir -p $out/share/fish/vendor_completions.d
              echo 'complete batman --wraps man' > $out/share/fish/vendor_completions.d/batman.fish

              mkdir -p $out/share/zsh/site-functions
              cat << EOF > $out/share/zsh/site-functions/_batman
              #compdef batman
              _man "$@"
              EOF
            '';
        }))
      ];
    };
  };
  home = {

    shellAliases = let

      params =
        "--git --icons --classify --group-directories-first --time-style=long-iso --group --color-scale all";
    in {

      help =
        ''"$@" --help 2>&1 | ${lib.getExe pkgs.bat} --plain --language=help'';

      # general
      c = "clear";
      isodate = ''date -u "+%Y-%m-%dT%H:%M:%SZ"'';
      man = "batman";
      mime = "xdg-mime query filetype";
      mkdir = "mkdir -p";
      mount = "mount --mkdir";
      open = "xdg-open";
      py = "${lib.getExe pkgs.python3}";

      d = "setsid $@ &>/dev/null";

      matrix = "${lib.getExe pkgs.unimatrix} -f -l ocCgGkS -s 96";

      # cd aliases
      ".." = "cd ..";
      "..." = "cd ../..";

      # cat aliases
      bcat = "${lib.getExe pkgs.bat} -l bash";
      dcat = "${lib.getExe pkgs.bat} --decorations=always";

      # ls aliases
      ls = "${lib.getExe pkgs.eza} ${params}";
      l = "${lib.getExe pkgs.eza} --git-ignore ${params}";
      ll = "${lib.getExe pkgs.eza} --all --header --long ${params}";
      llm = "${
          lib.getExe pkgs.eza
        } --all --header --long --sort=modified ${params}";
      la = "${lib.getExe pkgs.eza} -lbhHigUmuSa";
      lsa = "${lib.getExe pkgs.eza} -ahF";
      lx = "${lib.getExe pkgs.eza} -lbhHigUmuSa@";
      lt = "${lib.getExe pkgs.eza} --tree ${params}";
      tree = "${lib.getExe pkgs.eza} --tree ${params}";

      font-family = "fc-list : family | ${lib.getExe pkgs.fzf}";

    };

    packages = let
      generate-script = attrs:
        lib.attrsets.mapAttrsToList (name: value:
          (pkgs.writeShellApplication {
            inherit name;
            bashOptions = [ "pipefail" ];
            text = ''
              ${value}
            '';
          })) attrs;

      packages = {
        cat = # bash
          ''
            paged=false
            batarg=("--tabs" "2")
            for arg in "$@"; do
              case "$arg" in
              -p) paged=true ;;
              *) batarg+=("$arg") ;;
              esac
            done

            if ! "$paged"; then
              batarg+=(-pp)
            fi

            ${lib.getExe pkgs.bat} "''${batarg[@]}"
          '';
        myip = # bash
          ''
            [ $# -gt 0 ] && arg="$1" || arg=""
            if [ "$arg" = "-g" ]; then
              ${lib.getExe pkgs.curl} -s http://ipecho.net/plain
              echo
            else
              echo -e "$(${
                lib.getExe' pkgs.iproute2 "ip"
              } route get 1.2.3.4 | ${
                lib.getExe' pkgs.gawk "awk"
              } '{print $7}' | sed -z 's/\n/ /g')"
            fi
          '';

        shell = # bash
          ''
            # Initialize empty arrays for package names and options
            ps=()
            os=()

            # Loop through all the arguments
            for p in "$@"; do
                if [[ "$p" != --* ]]; then
                    # If not an option, add it to the package names array
                    ps+=("nixpkgs#$p")
                else
                    # If it is an option, add it to the options array
                    os+=("$p")
                fi
            done

            # Construct the command
            cmd="SHELL=$(which zsh) IN_NIX_SHELL=\"impure\" nix shell ''${os[*]} ''${ps[*]}"
            echo "Executing \`$cmd\`..."

            # Execute the command
            eval "$cmd"
          '';
      };
    in (generate-script packages);
  };
}
