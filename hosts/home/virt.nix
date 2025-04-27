{
  self,
  inputs,
  pkgs,
  opts,
  ...
}:
let
  inherit (opts) username userEmail;
in
{
  imports = [
    self.homeModules.home # home-manager common settings
    self.homeModules.shell
    self.homeModules.editor
  ];

  config = {
    nvix.pkg = inputs.nvix.packages.${pkgs.system}.core;
    programs.git = {
      inherit userEmail;
      userName = username;
    };
  };
}
