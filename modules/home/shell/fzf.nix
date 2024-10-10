{ lib, pkgs, ... }:
let
  binds = [
    "--bind='ctrl-d:preview-down'"
    "--bind='ctrl-u:preview-up'"
    "--bind='ctrl-/:deselect'"
    "--bind='ctrl-space:select'"
    "--bind='ctrl-p:change-preview-window(down|hidden|)'"
    "--bind='alt-u:page-up+refresh-preview'"
    "--bind='alt-d:page-down+refresh-preview'"
    "--bind='alt-y:yank'"
    "--bind='ctrl-g:top'"
    "--bind='alt-a:toggle-all'"
    "--bind='alt-s:toggle-sort'"
    "--bind='alt-h:backward-char+refresh-preview'"
    "--bind='alt-l:forward-char+refresh-preview'"
    "--bind='ctrl-l:clear-screen'"
  ];

  defaultOptions = binds ++ [
    "--height 60%"
    "--info inline-right"
    "--layout reverse"
    "--marker ▏"
    "--pointer ▌"
    "--prompt '▌ '"
    "--highlight-line"
    "--color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189"
  ];

  fzf-preview = pkgs.writeShellApplication {
    name = "fzf-preview";
    runtimeInputs = with pkgs; [
      # general
      file

      # for images
      exiftool
      chafa
      mediainfo

      # for text
      bat
      jq
      glow
      w3m

      # filesystem
      eza

      openssl
      coreutils
      ffmpegthumbnailer
      gnutar
      unzip
      p7zip
      xz
      gnumeric
      python312Packages.docx2txt
      odt2txt
      catdoc
      poppler_utils
      fd
    ];
    text = ''
      if [[ $# -ne 1 ]]; then
        >&2 echo "usage: $0 FILENAME"
        exit 1
      fi

      handle_text() {
        case "$2" in
        *.md) glow --style=auto "$2" ;;
        # *.htm | *.html) elinks -dump "$2" ;;
        *.htm | *.html) w3m -T text/html -dump "$2" ;;
        *) bat -p --color=always "$2" ;;
        esac
      }

      handle_image() {
        case "$1" in

        image/*)
          chafa -f sixel -s "''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}" "$2" --animate false
          mediainfo "$2"
          ;;
        *) exiftool -All "$2" ;;
        esac
      }

      test -d "$HOME/.cache/fzf" || mkdir -p "$HOME/.cache/fzf"
      cache="$HOME/.cache/fzf/thumbnail.$(echo -n "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
      mime="$(file --brief --mime-type "$1")"

      case "$mime" in
      text/*) handle_text "$mime" "$1" ;;
      application/json) bat -l json "$1" ;;
      inode/directory) eza --tree -L 2 "$1" ;;
      inode/symlink) printf "Symbolic link to: \e[34m%s\e[0m." "$(readlink "$1")" ;;
      application/x-bittorrent) transmission-show --unsorted "$1" ;;
      application/x-executable | application/x-pie-executable | application/x-sharedlib) readelf --wide --demangle=auto --all "$1" ;;
      application/x-x509-ca-cert) openssl x509 -text -noout -in "$1" ;;
      application/pdf)
        pdftoppm -jpeg -f 1 -singlefile "$1" "$cache"
        handle_image "image/*" "$cache.jpg"
        ;;
      image/*)
        handle_image "$mime" "$1"
        ;;
      video/*)
        ffmpegthumbnailer -i "$1" -o "''${cache}.jpg" -s 1200
        handle_image "image/*" "''${cache}.jpg"
        ;;

      *)
        case "$(printf "%s\n" "$(readlink -f "$1")" | awk '{print tolower($0)}')" in
        *.tgz | *.tar.gz) tar tzf "$1" ;;
        *.tar.bz2 | *.tbz2) tar tjf "$1" ;;
        *.tar.txz | *.txz) xz --list "$1" ;;
        *.tar | *.tar.xz) tar tf "$1" ;;
        *.zip | *.jar | *.war | *.ear | *.oxt) unzip -l "$1" ;;
        *.rar) unrar l "$1" ;;
        *.7z) 7z l "$1" ;;
        *.[1-8]) man "$1" | col -b ;;
        *.o) nm "$1" ;;
        *.torrent) transmission-show "$1" ;;
        *.iso) iso-info --no-header -l "$1" ;;
        *.odt | *.ods | *.odp | *.sxw) odt2txt "$1" ;;
        *.doc) catdoc "$1" ;;
        *.docx) docx2txt "$1" - ;;
        *.xls | *.xlsx)
          ssconvert --export-type=Gnumeric_stf:stf_csv "$1" "fd://1" | bat --language=csv
          ;;
        *.wav | *.mp3 | *.flac | *.m4a | *.wma | *.ape | *.ac3 | *.og[agx] | *.spx | *.opus | *.as[fx] | *.mka)
          exiftool "$1"
          ;;
        *.svg)
          [ ! -f "''${cache}.jpg" ] &&
            convert "$1" "''${cache}.jpg"
          handle_image "image/*" "''${cache}.jpg"
          ;;
        *)
          exit 1
          ;;
        esac
        ;;
      esac
    '';
  };

  commands = [
    # list of commands to be previewed by fzf-tab
    "cat"
    "bat"
    "cd"
    "cp"
    "mv"
    "advcp"
    "advmv"
    "ls"
    "vim"
    "nvim"
    "lsd"
    "eza"
    "xdg-open"
    "rsync"

    # below are the aliases
    "e"
    "rcp"
    "srcp"
    "open"
    "dopen"
  ];

  fzf-tab-preview = cmd: ''
    zstyle ':fzf-tab:complete:${cmd}:*' fzf-preview '${
      lib.getExe fzf-preview
    } $realpath'
  '';

  preview-cmd = "${lib.getExe fzf-preview} {$1}";

in
{
  programs = {
    ripgrep.enable = true;
    fd = {
      enable = true;
      ignores = [ ".git/" "*.bak" ];
    };

    fzf = {

      enable = true;
      inherit defaultOptions;

      enableZshIntegration = true;
      defaultCommand = "${lib.getExe pkgs.fd} --type f";
      changeDirWidgetCommand = "${lib.getExe pkgs.fd} --type d";
      fileWidgetCommand = "${lib.getExe pkgs.fd} --type f";
      changeDirWidgetOptions = binds ++ [ "--preview='${preview-cmd}'" ];
      fileWidgetOptions = binds ++ [ "--preview='${preview-cmd}'" ];
    };

    zsh = {
      plugins = with pkgs; [{
        name = "zsh-fzf-tab";
        src = zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }];
      initExtra = # sh
        ''
          bindkey '^[j' fzf-tab-complete
          bindkey '^[k' fzf-tab-complete

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle '*:fzf-tab:*' fzf-min-height 30
          # disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false
          # set descriptions format to enable group support
          zstyle ':completion:*:descriptions' format '[%d]'
          # set list-colors to enable filename colorizing
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

          ${lib.concatStringsSep "\n" (map fzf-tab-preview commands)}

          zstyle ':fzf-tab:complete:(\\|)run-help:*' ${
            lib.getExe fzf-preview
          } 'run-help $word'
          zstyle ':fzf-tab:complete:(\\|*/|)man:*' ${
            lib.getExe fzf-preview
          } 'man $word'

          # switch group using `,` and `.`
          zstyle ':fzf-tab:*' switch-group ',' '.'
          zstyle ':fzf-tab:complete:systemctl-*:*' ${
            lib.getExe fzf-preview
          } 'SYSTEMD_COLORS=1 systemctl status $word'

        '';
    };

  };
}
