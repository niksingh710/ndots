{ self, ... }:
{
  nixpkgs.overlays = [
    self.overlays.nixos
  ];
}
