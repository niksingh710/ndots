{
  programs.waybar.settings.mainBar = {
    modules-left = [ "hyprland/workspaces" "hyprland/submap" ];

    "hyprland/submap" = {
      "format" = "<b>󰇘</b>";
      "max-length" = 8;
      "tooltip" = true;
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      all-outputs = true;
      format-icons = {
        "1" = "१";
        "2" = "२";
        "3" = "३";
        "4" = "४";
        "5" = "५";
        "6" = "६";
        "7" = "७";
        "8" = "८";
        "9" = "९";
        "10" = "०";
      };
    };

  };
}
