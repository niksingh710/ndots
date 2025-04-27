{ config, opts, lib, ... }: with lib;
# This file is to contain common impermanence persistent dirs/files
# if any host require something host specific define it under host dir
# make sure home-manger nixosModule is imported
{
  persist.dir = [
    "/var/lib/sops/age"
    "/var/lib/bluetooth"
    "/var/lib/libvirt"
    "/var/lib/waydroid"
    "/etc/waydroid"
  ];
  hm.persist = {
    dir = [
      ".config/OpenTabletDriver"
      ".config/kdeconnect"
      ".config/kde.org"
      ".config/Zulip"

      ".local/share/task"
      ".config/syncall"

      ".local/share/Steam"
      ".steam"
      ".config/heroic"
      ".config/unity3d"
      ".config/supertuxkart"
      ".minecraft"

      ".local/share/waydroid"
      ".local/share/applications"
      ".local/share/fractal"
      ".local/share/onlyoffice"

      ".config/whatsapp-for-linux"
      ".config/Slack"

      ".config/google-chrome"
      ".zen"
      ".mozilla"
      ".librewolf"

      ".local/share/zoxide"
      ".cache/zsh"

      ".cache/nsearch"

      ".local/share/nvim"
      ".local/state/nvim"
      ".local/state/nix/profiles/channels" # determinate nix log spam fix
      ".config/github-copilot"
      ".cache/nvim"

      ".cache/nix-index"
      ".android"

      ".local/state/lazygit"
      ".local/share/direnv"

      ".local/state/mpv"

      ".config/discord"

      ".config/Proton"
      ".config/Proton Pass"

      ".local/share/TelegramDesktop"
      ".local/share/materialgram"
      ".cache/stylix-telegram-theme"

      ".local/state/wireplumber"
      ".config/pulse"
      ".config/Mailspring"

      "Downloads"
      "Pictures"
      "Documents"
      "Videos"

      "repos"
      "work"
      "share"
      "temp"
    ];
    files = [
      ".temp.zsh"
      ".gtasks_credentials.pickle"
    ];
  };
  environment = mkIf config.ndots.disk.impermanence {
    persistence."/persistent" = {
      directories = config.persist.dir;
      files = config.persist.files;
      users.${opts.username} = {
        directories = config.hm.persist.dir;
        files = config.hm.persist.files;
      };
    };
  };
}
