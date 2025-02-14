# 🚀 Overlays

My set of overlays for packages to be applied on different set of configurations.

### 🔨 Import the overlay on the config

```nix
{ self, ... }:
{
  nixpkgs.overlays = [
    self.overlays.<overlay-name>
  ];
}
```
