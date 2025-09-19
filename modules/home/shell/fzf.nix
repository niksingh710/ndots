{ pkgs, lib, ... }:
let
  # TODO: Make fzf-preview available in nixpkgs.
  # https://github.com/NixOS/nixpkgs/pull/420244
  fzf-preview =
    (builtins.getFlake "github:niksingh710/fzf-preview/422198e735c7b5f2a327e2f1a092c8c86d8c8233").packages.${pkgs.system}.default;
  binds = [
    "--bind='ctrl-d:preview-down'"
    "--bind='ctrl-u:preview-up'"
    "--bind='ctrl-space:toggle'"
    "--bind='ctrl-s:toggle-sort'"
    "--bind='ctrl-y:yank'"
    "--bind='ctrl-alt-p:change-preview-window(down|hidden|)'"
  ];
  defaultOptions = binds ++ [
    "--height 60%"
    "--info inline-right"
    "--layout=reverse"
    "--highlight-line"
    "--multi"
    "--color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189"
  ];
  sortFilesCmd = "${lib.getExe pkgs.eza} -s modified -1 --no-quotes --reverse";
in
{
  home.sessionVariables.FZF_TMUX = lib.mkForce 0;
  programs = {
    sesh.settings = {
      preview_command = "${lib.getExe fzf-preview} {}";
    };
    ripgrep.enable = true;
    fzf = {
      enable = true;
      inherit defaultOptions;
      defaultCommand = "fd -t f";
      changeDirWidgetCommand = "fd -t d";
      fileWidgetCommand = "fd -t f -X ${sortFilesCmd}";
      fileWidgetOptions = binds ++ [ "--preview='${lib.getExe fzf-preview} {}'" ];
      changeDirWidgetOptions = binds ++ [ "--preview='${lib.getExe pkgs.eza} -T {}'" ];
    };
    zsh.initContent = # sh
      ''
        function zvm_after_init() {
          zvm_bindkey viins "^R" fzf-history-widget

          # `ctrl + space` to accept autosuggestions
          # for macOs make sure `ctrl + space` is passed to the terminal
          bindkey '^ ' autosuggest-accept
        }
      '';
    fd = {
      enable = true;
      hidden = true;
      extraOptions = [
        "--no-ignore"
        "--follow"
        "--absolute-path"
      ];
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
  };

  home.packages = [
    fzf-preview
    pkgs.nsearch
  ];
  home.shellAliases.fzfp = "${lib.getExe pkgs.fzf} --preview='${lib.getExe fzf-preview} {}'";
}
