{ lib, pkgs, config, ... }: with lib;
let
  inherit (config.lib.stylix) colors;
in
{
  environment.systemPackages = with pkgs; [
    heroic
  ];
  hm.home.file.".config/heroic-theme/stylix.css".text =
    with colors;
    # scss
    ''
      :root {
        --accent: #${base06};
        --accent-overlay: #${base02};
        --navbar-accent: #${base06};
        --background: #${base00};
        --body-background: var(--background);
        --background-darker: var(--body-background);
        --current-background: var(--body-background);
        --navbar-background: #${base00};
        --navbar-active-background: #${base00};
        --gradient-body-background: linear-gradient(
          90deg,
          var(--background-darker) -32px,
          var(--body-background) 64px,
          var(--body-background) 100%
        );
        --input-background: #${base01};
        --modal-background: var(--body-background);
        --modal-border: var(--body-background);
        --success: #${base01};
        --success-hover: #7F148E;
        --primary: #${base0B};
        --primary-hover: #${base0F};
        --danger: red;
        --text-log: #8C909B;
        --text-title: #E9EAEB;
        --text-default: var(--text-title);
        --text-secondary: #92A4AB;
        --osk-background: var(--body-background);
        --osk-button-background: var(--input-background);
        --osk-button-border: var(--navbar-background);
        --action-icon: #92A4AB;
        --action-icon-hover: var(--accent-overlay);
        --action-icon-active: var(--text-default);
      }
    '';
}
