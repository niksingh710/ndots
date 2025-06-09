{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  fzf-preview = inputs.fzf-preview.packages.${pkgs.system}.default;
  binds = [
    "--bind='ctrl-d:preview-down'"
    "--bind='ctrl-u:preview-up'"
    "--bind='ctrl-space:toggle'"
    "--bind='ctrl-s:toggle-sort'"
    "--bind='ctrl-y:yank'"
    "--bind='ctrl-p:change-preview-window(down|hidden|)'"
  ];
  defaultOptions = binds ++ [
    "--height 60%"
    "--info inline-right"
    "--layout=reverse"
    "--marker ▏"
    "--pointer ▌"
    "--prompt '▌ '"
    "--highlight-line"
    "--multi"
    "--color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189"
  ];
  sortFilesCmd = "${lib.getExe pkgs.eza} -s modified -1 --no-quotes --reverse";
in
{
  home.packages = [ fzf-preview ];
  home.shellAliases.fzfp = "${lib.getExe pkgs.fzf} --preview='${lib.getExe fzf-preview} {}'";
  programs = {
    zsh.initContent = # sh
      ''
        function zvm_after_init() {
          zvm_bindkey viins "^R" fzf-history-widget
        }
        bindkey '^ ' autosuggest-accept
      '';
    ripgrep.enable = true;
    fd = {
      enable = true;
      ignores = [
        ".git/"
        "*.bak"
      ];
    };
    fzf = {
      enable = true;
      inherit defaultOptions;
      defaultCommand = "${lib.getExe pkgs.fd} --type f";
      changeDirWidgetCommand = "${lib.getExe pkgs.fd} --type d";
      fileWidgetCommand = "${lib.getExe pkgs.fd} -t f -X ${sortFilesCmd}";
      fileWidgetOptions = binds ++ [ "--preview='${lib.getExe fzf-preview} {}'" ];
      changeDirWidgetOptions = binds ++ [ "--preview='${lib.getExe pkgs.eza} -T {}'" ];
    };
  };
}
