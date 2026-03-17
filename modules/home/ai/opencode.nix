{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    web.enable = false;
    settings = {
      model = "litellm/open-large";
      agent = {
        explore = {
          mode = "subagent";
          model = "litellm/open-fast";
        };
      };
      autoupdate = true;
      provider = {
        litellm = {
          npm = "@ai-sdk/openai-compatible";
          name = "Juspay";
          options = {
            baseURL = "https://grid.ai.juspay.net";
            apiKey = "{env:ANTHROPIC_AUTH_TOKEN}";
            timeout = 600000;
          };
          models = {
            open-large = {
              name = "open-large";
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [
                  "text"
                ];
              };
              limit = {
                "context" = 202752;
                "output" = 32000;
              };
            };
            kimi-latest = {
              name = "kimi-latest";
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
              };
              limit = {
                context = 262000;
                output = 32000;
              };
            };
          };
        };
      };
    };
  };
}
