{ pkgs, config, opts, ... }:
with config.lib.stylix.colors; {
  stylix.targets.vesktop.enable = false;
  persist.dir = [ ".config/vesktop" ];
  home = {
    packages = with pkgs; [ vesktop ];
    file.".config/vesktop/themes/midnight.stylix.css".text = # css
      ''

        @import url('https://refact0r.github.io/midnight-discord/midnight.css');

        :root {
        	--font: '${config.stylix.fonts.sansSerif.name}';

        	--corner-text: '${opts.username}';

        	--divider-thickness: 3px;

        	--online-indicator: #23a55a; /* change to #23a55a for default green */
        	--dnd-indicator: var(--accent-3); /* change to #f23f43 for default red */
        	--idle-indicator: #f23f43; /* change to #f0b232 for default yellow */
        	--streaming-indicator: #593695; /* change to #593695 for default purple */

        	--accent-1: #${base01}; /* links */
        	--accent-2: #${base01}; /* general unread/mention elements */
        	--accent-3: #${base01}; /* accent buttons */
        	--accent-4: #${base02}; /* accent buttons when hovered */
        	--accent-5: #${base02}; /* accent buttons when clicked */
        	--mention: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.1); /* mentions & mention messages */
        	--mention-hover: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.05); /* mentions & mention messages when hovered */

        	--text-0: var(--text-2); /* text on colored elements */
        	--text-1: #${base0B}; /* other normally white text */
        	--text-2: #${base0C}; /* headings and important text */
        	--text-3: #${base0D}; /* normal text */
        	--text-4: #${base0B}; /* icon buttons and channels */
        	--text-5: #${base0F}; /* muted channels/chats and timestamps */

        	--bg-1: #${base00}; /* dark buttons when clicked */
        	--bg-2: #${base00}; /* dark buttons */
        	--bg-3: #${base00}; /* spacing, secondary elements */
        	--bg-4: #00000077; /* main background color */
        	--hover: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.1); /* channels and buttons when hovered */
        	--active: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.2); /* channels and buttons when clicked or selected */
        	--message-hover: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.1); /* messages when hovered */

        	--spacing: 12px;

        	--list-item-transition: 0.2s ease; /* channels/members/settings hover transition */
        	--unread-bar-transition: 0.2s ease; /* unread bar moving into view transition */
        	--moon-spin-transition: 0.4s ease; /* moon icon spin */
        	--icon-spin-transition: 1s ease; /* round icon button spin (settings, emoji, etc.) */

        	/* corner roundness (border-radius) */
        	--roundness-xl: 22px; /* roundness of big panel outer corners */
        	--roundness-l: 20px; /* popout panels */
        	--roundness-m: 16px; /* smaller panels, images, embeds */
        	--roundness-s: 12px; /* members, settings inputs */
        	--roundness-xs: 10px; /* channels, buttons */
        	--roundness-xxs: 8px; /* searchbar, small elements */

        	/* direct messages moon icon */
        	/* change to block to show, none to hide */
        	--discord-icon: none; /* discord icon */
        	--moon-icon: none; /* moon icon */
        	--moon-icon-url: none;
        	--moon-icon-size: auto;

        	/* filter uncolorable elements to fit theme */
        	/* (just set to none, they're too much work to configure) */
        	--login-bg-filter: saturate(0.3) hue-rotate(-15deg) brightness(0.4); /* login background artwork */
        	--green-to-accent-3-filter: hue-rotate(56deg) saturate(1.43); /* add friend page explore icon */
        	--blurple-to-accent-3-filter: hue-rotate(304deg) saturate(0.84) brightness(1.2); /* add friend page school icon */
        }

        html.theme-light,
        .theme-dark {
          --background-floating: var(--bg-1) !important;
          --background-nested-floating: var(--bg-1) !important;
        }
        .childWrapper_f90abb:has(> svg:not(.favoriteIcon_dcc7a4)) {
        	background-image: url('https://raw.githubusercontent.com/NYRI4/LilyPichu/main/assets/icon.png');
        	background-color: transparent !important;
        	background-size: cover;
        	background-position: center;
        }
      '';
  };
}
