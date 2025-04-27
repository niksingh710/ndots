{
  programs.waybar.settings.mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "hyprland/submap"
      "group/info"
    ];

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

    "group/info" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [
        "custom/dmark"
        "group/gcpu"
        "memory"
        "disk"
      ];
    };
    "custom/dmark" = {
      format = "";
      tooltip = false;
    };
    "group/gcpu" = {
      orientation = "inherit";
      modules = [ "cpu" ];
    };
    cpu = {
      format = " 󰻠\n{usage}%";
      on-click = "foot btop";
    };
    memory = {
      on-click = "foot btop";
      format = "  \n{}%";
    };
    disk = {
      on-click = "foot btop";
      interval = 600;
      format = " 󰋊\n{percentage_used}%";
      path = "/";
    };
  };
}
