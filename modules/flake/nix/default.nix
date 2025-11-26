# Common module for NixOs and darwin
{
  imports =
    with builtins;
    map (file: ./${file}) (filter (file: (file != "default.nix")) (attrNames (readDir ./.)));
}
