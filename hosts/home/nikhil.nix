{ flake, ... }:
let
  me = (import (flake + "/config.nix")).me // {
    username = "nikhil.singh";
  };
in
{
  imports = [
    flake.homeModules.default
  ];
  home.username = "nikhil";
  programs.zsh.completionInit = "autoload -U compinit && compinit -i";
  programs.git = {
    settings = {
      user = {
        name = me.fullname;
        email = me.email;
      };
    };
    includes = [
      {
        condition = "gitdir:~/work/bitbucket/";
        contents.user.email = "${me.username}@juspay.in";
      }
    ];
  };
}
