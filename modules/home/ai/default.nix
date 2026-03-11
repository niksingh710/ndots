{
  home.sessionVariables = {
    CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS = 1;
    ANTHROPIC_MODEL = "claude-sonnet-4-5";
  };
  imports =
    with builtins;
    map (file: ./${file}) (filter (file: (file != "default.nix")) (attrNames (readDir ./.)));
}
