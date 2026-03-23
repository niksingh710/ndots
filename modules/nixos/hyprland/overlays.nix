{
  pkgs,
  config,
  ...
}:
let
  utils = pkgs.putils;
  inherit (config.lib.stylix) colors;
  args = [
    "--password-store=\"gnome-libsecret\""
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
  ];
  common = (
    with colors;
    # scss
    ''
      * {
          background: #${base00};
          background-alt: #${base03};
          selected: #${base02};
          foreground: #${base06};
        }
      window {
          background: transparent;
          location: south;
          anchor: south;
        }
    ''
  );
in
{
  nixpkgs.overlays = [
    (next: prev: {
      rofi-clients = utils.clients.override (
        with colors;
        {
          uwsm = true;
          rofi-theme-str = # scss
            ''
              * {
                  background: #${base00};
                  background-alt: #${base03};
                  selected: #${base02};
                  foreground: #${base06};
                }
              window {
                background: transparent;
                }
            '';
        }
      );
      rofi-menus = utils.menus.override {
        network-theme-str = common;
        bt-theme-str = common;
        audio-theme-str = common;
      };
      rofi-fullmenu = utils.fullmenu.override {
        full-theme-str = common;
      };
      mailspring = prev.mailspring.overrideAttrs (oa: {
        postFixup = ''
          substituteInPlace $out/share/applications/Mailspring.desktop \
            --replace-fail Exec=mailspring Exec="$out/bin/mailspring ${builtins.concatStringsSep " " args}"
        '';
        postInstall = (oa.postInstall or "") + ''
          wrapProgram $out/bin/mailspring \
            --prefix LD_LIBRARY_PATH : "${next.lib.makeLibraryPath [ pkgs.libglvnd ]}" \
            --add-flags "${builtins.concatStringsSep " " args}"
        '';
      });
    })
  ];
}
