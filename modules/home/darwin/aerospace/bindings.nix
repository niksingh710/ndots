{ pkgs, lib, ... }:
let
  # I map holding of `capslock` key to `cmd+alt` in karabiner-elements
  # TODO: Assign workspaces with accordion layout to apps for comms
  # NOTE: Keep everything in one service mode, multiple modes maybecome confusing
  mod = "cmd-alt";
  scratchpad = lib.getExe' (builtins.getFlake "github:cristianoliveira/aerospace-scratchpad/3118229ccb1ec0a6ee9ca166ea19ff5d08cdfd66").packages.${pkgs.system}.default "aerospace-scratchpad";
  scratchpadCmd = "exec-and-forget ${scratchpad}";
in
{
  programs.aerospace.userSettings.mode = {
    main.binding = {
      "${mod}-shift-semicolon" = "mode service";
      "${mod}-shift-r" = "mode resize";

      "${mod}-q" = "close";

      # layouts
      "${mod}-shift-slash" = "layout accordion tiles horizontal";

      # Focus window
      "${mod}-h" = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors left";
      "${mod}-j" = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors down";
      "${mod}-k" = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors up";
      "${mod}-l" = "focus --boundaries all-monitors-outer-frame --boundaries-action wrap-around-all-monitors right";

      # Move window
      "${mod}-shift-h" = "move left";
      "${mod}-shift-j" = "move down";
      "${mod}-shift-k" = "move up";
      "${mod}-shift-l" = "move right";

      # Moving window to monitor
      "${mod}-shift-space" = "move-node-to-monitor --wrap-around --focus-follows-window next";
      # Focus next/previous monitor
      "${mod}-space" = "focus-monitor --wrap-around next";

      cmd-h = [ ]; # Disable "hide application"
      # cmd-alt-h = []; # Disable "hide others"

      # workspace
      "${mod}-1" = "workspace 1";
      "${mod}-2" = "workspace 2";
      "${mod}-3" = "workspace 3";
      "${mod}-4" = "workspace 4";
      "${mod}-5" = "workspace 5";
      "${mod}-6" = "workspace 6";
      "${mod}-7" = "workspace 7";
      "${mod}-8" = "workspace 8";
      "${mod}-9" = "workspace 9";
      "${mod}-0" = "workspace 10";

      "${mod}-n" = "workspace next";
      "${mod}-p" = "workspace prev";

      "${mod}-shift-n" = "move-node-to-workspace --wrap-around next --focus-follows-window";
      "${mod}-shift-p" = "move-node-to-workspace --wrap-around prev --focus-follows-window";

      # move node to workspace
      "${mod}-shift-1" = "move-node-to-workspace --focus-follows-window 1";
      "${mod}-shift-2" = "move-node-to-workspace --focus-follows-window 2";
      "${mod}-shift-3" = "move-node-to-workspace --focus-follows-window 3";
      "${mod}-shift-4" = "move-node-to-workspace --focus-follows-window 4";
      "${mod}-shift-5" = "move-node-to-workspace --focus-follows-window 5";
      "${mod}-shift-6" = "move-node-to-workspace --focus-follows-window 6";
      "${mod}-shift-7" = "move-node-to-workspace --focus-follows-window 7";
      "${mod}-shift-8" = "move-node-to-workspace --focus-follows-window 8";
      "${mod}-shift-9" = "move-node-to-workspace --focus-follows-window 9";
      "${mod}-shift-0" = "move-node-to-workspace --focus-follows-window 10";

      "${mod}-shift-f" = "layout floating tiling";
      "${mod}-m" = "fullscreen"; # i use f for homerow

      "${mod}-o" = "workspace-back-and-forth";
      "${mod}-c" = "workspace Comms";
      "${mod}-shift-c" = "move-node-to-workspace --focus-follows-window Comms";
      "${mod}-shift-tab" = "move-workspace-to-monitor --wrap-around next";

      "${mod}-left" = "join-with left";
      "${mod}-down" = "join-with down";
      "${mod}-up" = "join-with up";
      "${mod}-right" = "join-with right";

      "${mod}-backspace" = "close-all-windows-but-current";
      "${mod}-minus" = "resize smart -50";
      "${mod}-equal" = "resize smart +50";

      "${mod}-quote" = "mode scratchpad";

      "${mod}-enter" = "exec-and-forget open -a kitty";
      "${mod}-comma" = "${scratchpadCmd}";
    };
    scratchpad.binding = {
      quote = [ "${scratchpadCmd} show Slack" "mode main" ];
      "${mod}-quote" = [ "${scratchpadCmd} show Slack" "mode main" ];
      t = [ "${scratchpadCmd} show Telegram" "mode main" ];
      esc = [ "mode main" ];
      q = [ "mode main" ];
    };
    resize.binding = {
      h = "resize width -50";
      j = "resize height +50";
      k = "resize height -50";
      l = "resize width +50";
      enter = "mode main";
      esc = "mode main";
    };
    service.binding = {
      esc = [ "reload-config" "mode main" ];
      r = [ "reload-config" "mode main" ];
      e = [ "enable toggle" ];
      f = [ "flatten-workspace-tree" "mode main" ]; # reset layout

      "${mod}-shift-h" = [ "join-with left" "mode main" ];
      "${mod}-shift-j" = [ "join-with down" "mode main" ];
      "${mod}-shift-k" = [ "join-with up" "mode main" ];
      "${mod}-shift-l" = [ "join-with right" "mode main" ];
    };
  };
}
