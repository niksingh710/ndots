{ pkgs, ... }:
{

  # Configs that I use with 150 value for threshold
  # CapsLock Enhancement: https://ke-complex-modifications.pqrs.org/#caps_lock_enhancement
  # FIX: fix after: https://github.com/nix-darwin/nix-darwin/issues/1041
  services.karabiner-elements = {
    enable = true;
    package = pkgs.karabiner-elements.overrideAttrs (old: {
      version = "14.13.0";

      src = pkgs.fetchurl {
        inherit (old.src) url;
        hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
      };

      dontFixup = true;
    });
  };
}
