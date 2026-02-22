{
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
    "https://cache.nixos.asia/oss"
    "https://nvix.cachix.org"

  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
    "nvix.cachix.org-1:qVYAfj2oiH0DF3pSs8OfPYI6B0mAZ+h5mMajN+EOL2E="
  ];
}
