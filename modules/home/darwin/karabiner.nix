{ flake, ... }:
let
  inherit (flake.inputs) self;
in
{
  # TODO: ADD direct url in readme
  # <(karabiner://karabiner/assets/complex_modifications/import?url=<raw-json>)>

  # Make sure to import the quick_hyper.json file in complex_modifications
  home.file."karabiner-config" = {
    source = "${self}/misc/quick_hyper.karabiner.json";
    target = ".config/karabiner/assets/complex_modifications/quick_hyper.json";
  };
}
