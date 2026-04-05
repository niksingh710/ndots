{
  lib,
  pkgs,
  ...
}:
let
  # Fetch the OpenAgentsControl repository
  openagents-control = pkgs.fetchFromGitHub {
    owner = "darrenhinde";
    repo = "OpenAgentsControl";
    rev = "main";
    sha256 = "sha256-H5O08YjxzJMYva1sjMgCl5GTDrx9pR1ELBtO5bqGV/Y=";
  };

  # Read registry
  registry = builtins.fromJSON (builtins.readFile "${openagents-control}/registry.json");

  # Profile to install
  profile = "developer";

  # Get components for the profile
  allComponents = registry.profiles.${profile}.components or [ ];

  # Convert component spec to file mapping
  componentToFile =
    spec:
    let
      parts = lib.splitString ":" spec;
      compType = lib.elemAt parts 0;
      compId = lib.elemAt parts 1;
      # Registry uses plural keys
      registryKey = if lib.hasSuffix "s" compType then compType else compType + "s";
      components = registry.components.${registryKey} or [ ];
      matches = c: c.id == compId || lib.elem compId (c.aliases or [ ]);
      component = lib.findFirst matches null components;
    in
    if component == null then
      null
    else
      {
        name = ".config/opencode/${lib.removePrefix ".opencode/" component.path}";
        value.source = "${openagents-control}/${component.path}";
      };

in
{
  home.sessionVariables.OPENCODE_ENABLE_EXA = 1;
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    web.enable = false;
    settings = {
      permission = {
        # Allow read operations without prompting
        read = "allow";
        # Keep these on ask for safety
        write = "ask";
        edit = "ask";
        bash = "ask";
        task = "ask";
        lsp = "allow";
        grep = "allow";
        glob = "allow";
        skill = "allow";
        webfetch = "allow";
        websearch = "allow";
        questions = "allow";
        external_directory = {
          "~/.notes" = "allow";
        };
      };
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

  home.file = lib.listToAttrs (lib.filter (x: x != null) (map componentToFile allComponents));
}
