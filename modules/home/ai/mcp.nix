{ ... }:
{
  programs.mcp = {
    enable = true;
    servers = {
      newton-hs-prod = {
        autoApprove = [
          "search_functions_by_keyword"
          "query_to_function_meta_data"
        ];
        type = "http";
        url = "https://juspay-brain.internal.svc.k8s.office.mum.juspay.net/newton-hs/";
      };
      deepwiki = {
        type = "remote";
        url = "https://mcp.deepwiki.com/mcp";
        enabled = true;
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
