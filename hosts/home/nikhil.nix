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

  programs.git = {
    userName = me.fullname;
    userEmail = me.email;
    includes = [
      {
        condition = "gitdir:~/work/bitbucket/";
        contents.user.email = "${me.username}@juspay.in";
      }
    ];
  };
}
