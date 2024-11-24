{
  programs.fastfetch.enable = true;
  home.file.".config/fastfetch/config.jsonc".text = # jsonc
    ''
      {
        "logo": {
          "padding": {
            "top": 2
          }
        },
        "display": {
          "separator": " -> "
        },
        "modules": [
          {
            "type": "custom",
            "format": "\u001b[90m┌────────────────────────────────────────────────────────────┐"
          },
          {
            "type": "title",
            "keyWidth": 10
          },
          {
            "type": "custom",
            "format": "\u001b[90m└────────────────────────────────────────────────────────────┘"
          },
          {
            "type": "custom",
            "format": " \u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m  \u001b[38m  \u001b[39m       \u001b[38m  \u001b[37m  \u001b[36m  \u001b[35m  \u001b[34m  \u001b[33m  \u001b[32m  \u001b[31m  \u001b[90m"
          },
          {
            "type": "custom",
            "format": "\u001b[90m┌────────────────────────────────────────────────────────────┐"
          },
          {
            "type": "os",
            "key": " OS",
            "keyColor": "yellow"
          },
          {
            "type": "kernel",
            "key": "│ ├",
            "keyColor": "yellow"
          },
          {
            "type": "packages",
            "key": "│ ├󰏖",
            "keyColor": "yellow"
          },
          {
            "type": "shell",
            "key": "│ └",
            "keyColor": "yellow"
          },
          {
            "type": "wm",
            "key": " DE/WM",
            "keyColor": "blue"
          },
          {
            "type": "lm",
            "key": "│ ├󰧨",
            "keyColor": "blue"
          },
          {
            "type": "wmtheme",
            "key": "│ ├󰉼",
            "keyColor": "blue"
          },
          {
            "type": "icons",
            "key": "│ ├󰀻",
            "keyColor": "blue"
          },
          {
            "type": "terminal",
            "key": "│ ├",
            "keyColor": "blue"
          },
          {
            "type": "wallpaper",
            "key": "│ └󰸉",
            "keyColor": "blue"
          },
          {
            "type": "host",
            "key": "󰌢 PC",
            "keyColor": "green"
          },
          {
            "type": "cpu",
            "key": "│ ├󰻠",
            "keyColor": "green"
          },
          {
            "type": "gpu",
            "key": "│ ├﬙",
            "keyColor": "green"
          },
          {
            "type": "disk",
            "key": "│ ├",
            "keyColor": "green"
          },
          {
            "type": "memory",
            "key": "│ ├󰑭",
            "keyColor": "green"
          },
          {
            "type": "swap",
            "key": "│ ├󰓡",
            "keyColor": "green"
          },
          {
            "type": "display",
            "key": "│ ├󰍹",
            "keyColor": "green"
          },
          {
            "type": "uptime",
            "key": "│ └󰅐",
            "keyColor": "green"
          },
          {
            "type": "sound",
            "key": " SND",
            "keyColor": "cyan"
          },
          {
            "type": "player",
            "key": "│ ├󰥠",
            "keyColor": "cyan"
          },
          {
            "type": "media",
            "key": "│ └󰝚",
            "keyColor": "cyan"
          },
          {
            "type": "custom",
            "format": "\u001b[90m└────────────────────────────────────────────────────────────┘"
          },
          "break",
          {
            "type": "custom",
            "format": " \u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m  \u001b[38m  \u001b[39m       \u001b[38m  \u001b[37m  \u001b[36m  \u001b[35m  \u001b[34m  \u001b[33m  \u001b[32m  \u001b[31m  \u001b[90m"
          }
        ]
      }
    '';
}
