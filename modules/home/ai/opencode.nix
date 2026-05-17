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

  # Fetch anthropics/claude-code (source for vendored skills).
  # Bump the sha256 when bumping rev (or when 'main' moves and you want updates).
  claude-code = pkgs.fetchFromGitHub {
    owner = "anthropics";
    repo = "claude-code";
    rev = "main"; # TODO: pin to a specific commit for easy update/maintainability or better use <flake>
    sha256 = "sha256-eyjtPpiYyxgY5tH8jldg8AfJQr2u+w1eIiCSQgAdgws=";
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
    web = {
      enable = lib.mkDefault false;
      extraArgs = [ "--mdns" ];
    };
    settings = {
      provider = {
        anthropic.models.claude-opus-4-7 = {
          id = "claude-opus-4-7";
          name = "Bhai";
        };
      };
      default_agent = "OpenAgent";
      autoupdate = true;
    };
  };

  home.file = (lib.listToAttrs (lib.filter (x: x != null) (map componentToFile allComponents))) // {
    # Skills sourced directly from anthropics/claude-code
    ".config/opencode/skills/frontend-design/SKILL.md".source =
      "${claude-code}/plugins/frontend-design/skills/frontend-design/SKILL.md";
  };
}
