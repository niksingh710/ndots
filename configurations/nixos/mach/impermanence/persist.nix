{ flake, ... }:
{

  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/sops/age"
      "/var/lib/bluetooth"
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/var/lib/tailscale"
      "/etc/waydroid"


      # ---> Below are the required one for system to work <---
      "/etc/nixos"
      "/etc/secureboot"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"

      # Systemd requires /usr dir to be populated
      # See: https://github.com/nix-community/impermanence/issues/253
      "/usr/systemd-placeholder"
    ];
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
    users.${flake.config.me.username} =
      {
        files = [
          ".temp.zsh"
          ".gtasks_credentials.pickle"
        ];
        directories =
          let
            dir = name: {
              directory = "${name}";
              mode = "0700";
            };
          in
          [
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

            # --> Below are required one <--
            (dir ".gnupg")
            (dir ".ssh")
            (dir ".nixops")
            (dir ".local/share/keyrings")
          ];
      };
  };
}
