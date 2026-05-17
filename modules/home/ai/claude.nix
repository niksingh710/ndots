{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      preferences.vimMode = true;
      model = "claude-opus-4-6";
      env.ENABLE_TOOL_SEARCH = true;
    };
  };
}
