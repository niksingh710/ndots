{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) getExe;
in
{
  programs.mcp = {
    enable = true;
    servers = {
      # TODO: test some servers manually for better configurations
      git.command = getExe pkgs.mcp-server-git;
      time.command = getExe pkgs.mcp-server-time;
      fetch.command = getExe pkgs.mcp-server-fetch;
      memory.command = getExe pkgs.mcp-server-memory;
      github.command = getExe pkgs.github-mcp-server;
      sequential-thinking.command = getExe pkgs.mcp-server-sequential-thinking;
      everything = {
        command = getExe pkgs.mcp-server-filesystem;
        args = [
          "${config.home.homeDirectory}"
        ];
      };
      # TODO: Add this with api key and figure out a way to give the env to non sops enabled servers
      # context7 = {
      #   url = "https://mcp.context7.com/mcp";
      #   headers = {
      #     CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
      #   };
      # };
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
