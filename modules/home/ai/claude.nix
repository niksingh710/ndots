{
  home.sessionVariables = {
    CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS = 1;
    ANTHROPIC_MODEL = "claude-sonnet-4-5";
  };
  programs.claude-code = {
    enable = true;
    settings = {
      preferences.vimMode = true;
      model = "claude-sonnet-4-5";
      env.ENABLE_TOOL_SEARCH = true;
    };
    mcpServers = {
      newton-hs-prod = {
        autoApprove = [
          "search_functions_by_keyword"
          "query_to_function_meta_data"
        ];
        type = "http";
        url = "https://juspay-brain.internal.svc.k8s.office.mum.juspay.net/newton-hs/";
      };
      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };
  };
}
