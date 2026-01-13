let
  users = {
    "sunny.sehwag" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB9si+8/vDKLDskxjbmcGy/B6rKaU5M5D9E+eSQtwu3T";
    "prabhat.kumar" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMr6rWRFaYyaOky4+nKDA6QrQVh1GwS95KYB0bOpzbvf";
    "sebin.duke" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2EzDOXkYOyMAz7Jak7bDm//W+3qId+XyniC48ejv1B";
    "aditya.n" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6dH5htQfrDyFlwccLjBNrNOHE4Hd3HOSiNN0ZyxEsQ";
  };

  mkUsers = usersFromKeys: {
    users.users = builtins.mapAttrs (username: key: {
      isNormalUser = true;
      group = "extra";
      openssh.authorizedKeys.keys = [ key ];
    }) usersFromKeys;
  };
in
mkUsers users
