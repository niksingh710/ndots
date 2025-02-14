{ inputs, pkgs, config, ... }:
let
  utils = inputs.utils.packages.${pkgs.system};
  inherit (config.lib.stylix) colors;
  common = (with colors;
    # scss
    ''
      * {
          background: #${base00};
          background-alt: #${base03};
          selected: #${base02};
          foreground: #${base06};
        }
      window {
          location: south;
          anchor: south;
        }
    '');
in
{
  nixpkgs.overlays = [
    (self: super: {
      utils-clients = utils.clients.override (with colors; {
        rofi-theme-str = # scss
          ''
            * {
                background: #${base00};
                background-alt: #${base03};
                selected: #${base02};
                foreground: #${base06};
              }
          '';
      });
      utils-menus = utils.menus.override {
        network-theme-str = common;
        bt-theme-str = common;
        audio-theme-str = common;
      };
    })
  ];
}
