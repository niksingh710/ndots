{ pkgs, ... }:
{

  fonts.packages = with pkgs;[ nerd-fonts.jetbrains-mono monaspace ];
  environment.systemPackages = with pkgs; [ kanata-with-cmd ];

  environment.launchDaemons."org.nixos.kanata.plist" = {
    enable = true;
    # kanata path needs to be the linked one from /nix/var/nix/profiles/system/sw/bin/kanata
    # also make sure this got InputMonitering permission
    # After brew's karabiner installer open it, from login items make sure karabiner is not starting after reboot
    text = # xml
      ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>org.nixos.kanata</string>

            <key>ProgramArguments</key>
            <array>
                <string>/bin/sh</string>
                <string>-c</string>
                <string>/bin/wait4path /nix/store &amp;&amp; exec /nix/var/nix/profiles/system/sw/bin/kanata -c ${../../misc/kanata.kbd} -d --port 10000</string>
            </array>

            <key>RunAtLoad</key>
            <true/>

            <key>KeepAlive</key>
            <true/>

            <key>StandardOutPath</key>
            <string>/Library/Logs/Kanata/kanata.out.log</string>

            <key>StandardErrorPath</key>
            <string>/Library/Logs/Kanata/kanata.err.log</string>
        </dict>
        </plist>
      '';
  };

  homebrew = {
    casks = [
      "homerow"
      "caffeine"
      "zulip"
      "signal"
      "zen"
      "pronotes"
      "tailscale-app"
      "betterdisplay" # If annoys for premium remove it.
      "karabiner-elements"
    ];
    brews = [ "brew-cask-completion" ];
    masApps = {
      # only mac apps supported not iOS one
      # "tailscale" = 1475387142;
      "gifski" = 1351639930;
    };
  };

  homebrew = {
    enable = true;
    taps = [ ];
    onActivation = {
      upgrade = true;
      cleanup = "zap";
    };
  };
}
