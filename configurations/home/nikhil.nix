{ flake, ... }:
let
  inherit (flake) self;
  inherit (flake.config.me) email;

  username = "nikhil.singh";
in
{
  imports = [
    self.homeModules.default
  ];
  home.username = "nikhil";

  programs.git = {
    userName = flake.config.me.fullname;
    userEmail = email;
    includes = [
      {
        condition = "gitdir:~/work/bitbucket/";
        contents.user.email = "${username}@juspay.in";
      }
    ];
  };
}
