{ self, inputs, lib, opts, ... }: {

  imports = [

    inputs.home-manager.nixosModules.home-manager

    # Make sure to use hm = { imports = [ ./<homemanagerFiles> ];}; in nixosconfig

    {
      home-manager = {
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
    ./options.nix
    self.homeModules.home
  ];
}
