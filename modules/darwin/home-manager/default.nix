{
  self,
  inputs,
  lib,
  opts,
  ...
}:
let
  inherit (opts) username;
in
{

  imports = [

    inputs.home-manager.darwinModules.home-manager

    {
      users.users."${username}".home = "/Users/${username}";
      home-manager = {
        sharedModules = [
          inputs.mac-app-util.homeManagerModules.default
        ];
        backupFileExtension = "bak";
        extraSpecialArgs = { inherit opts inputs self; };
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }

    # config.home-manager.users.${user} -> config.hm
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" opts.username ])

  ];
  hm.imports = [
    self.homeModules.home
  ];
}
