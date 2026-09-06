{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.nixcord.quickCss =
    #css
    ''
      /**
         * @name system24
         * @description a tui-style discord theme.
         * @author refact0r
         * @version 2.1.0
         * @invite nz87hXyvcy
         * @website https://github.com/refact0r/system24
         * @source https://github.com/refact0r/system24/blob/master/theme/system24.theme.css
         * @authorId 508863359777505290
         * @authorLink https://www.refact0r.dev
      */

      /* import theme modules */
      @import url('https://refact0r.github.io/system24/build/system24.css');

      body {
          /* font, change to "" for default discord font */
          --font: 'DM MONO';
          --code-font: 'DM MONO';
          font-weight: 300;
          letter-spacing: -0.05ch;

          /* sizes */
          --gap: 12px;
          --divider-thickness: 4px;
          --border-thickness: 1px;
          --border-hover-transition: 0.2s ease;

          /* animation/transition options */
          --animations: on;
          --list-item-transition: 0.2s ease;
          --dms-icon-svg-transition: 0.4s ease;

          /* top bar options */
          --top-bar-height: var(--gap);
          --top-bar-button-position: titlebar;
          --top-bar-title-position: off;
          --subtle-top-bar-title: off;

          /* window controls */
          --custom-window-controls: off;
          --window-control-size: 14px;

          /* dms button options */
          --custom-dms-icon: custom;
          --dms-icon-svg-url: url("");
          --dms-icon-svg-size: 90%;
          --dms-icon-color-before: var(--icon-subtle);
          --dms-icon-color-after: var(--white);
          --custom-dms-background: off;
          --dms-background-image-url: url("");
          --dms-background-image-size: cover;
          --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2));

          /* background image options */
          --background-image: off;
          --background-image-url: url("");

          /* transparency/blur options */
          --transparency-tweaks: off;
          --remove-bg-layer: off;
          --panel-blur: off;
          --blur-amount: 12px;
          --bg-floating: var(--bg-3);

          /* other options */
          --small-user-panel: on;

          /* unrounding options */
          --unrounding: on;
          --round-pfp: off;
          --remove-pfp-decor: off;

          /* styling options */
          --custom-spotify-bar: on;
          --ascii-titles: on;
          --ascii-loader: system24;

          /* panel labels */
          --panel-labels: on;
          --label-color: var(--text-muted);
          --label-font-weight: 500;
      }

      /* color options */
      :root {
          --colors: on;

          /* text colors */
          --text-0: ${colors.base01}; /* text on colored elements */
          --text-1: ${colors.base05}; /* other normally white text */
          --text-2: ${colors.base06}; /* headings and important text */
          --text-3: ${colors.base04}; /* normal text */
          --text-4: ${colors.base03}; /* icon buttons and channels */
          --text-5: ${colors.base07}; /* muted channels/chats and timestamps */

          /* background and dark colors */
          --bg-1: ${colors.base03};
          --bg-2: ${colors.base02};
          --bg-3: ${colors.base01};
          --bg-4: ${colors.base00};
          --hover: color-mix(in srgb, ${colors.base05} 10%, transparent);
          --active: color-mix(in srgb, ${colors.base05} 20%, transparent);
          --active-2: color-mix(in srgb, ${colors.base05} 30%, transparent);
          --message-hover: var(--hover);

          /* accent colors */
          --accent-1: ${colors.base0A}; /* links and other accent text */
          --accent-2: ${colors.base0D}; /* small accent elements */
          --accent-3: ${colors.base0D}; /* accent buttons */
          --accent-4: color-mix(in srgb, ${colors.base0D} 80%, white); /* accent buttons hover */
          --accent-5: color-mix(in srgb, ${colors.base0D} 70%, white); /* accent buttons clicked */
          --accent-new: ${colors.base08}; /* mute/deafen etc */
          --mention: linear-gradient(to right, color-mix(in oklch, var(--accent-2), transparent 90%) 40%, transparent);
          --mention-hover: linear-gradient(to right, color-mix(in oklch, var(--accent-2), transparent 95%) 40%, transparent);
          --reply: linear-gradient(to right, color-mix(in oklch, var(--text-3), transparent 90%) 40%, transparent);
          --reply-hover: linear-gradient(to right, color-mix(in oklch, var(--text-3), transparent 95%) 40%, transparent);

          /* status indicator colors */
          --online   : ${colors.base0C};
          --dnd      : ${colors.base08};
          --idle     : ${colors.base0E};
          --streaming: ${colors.base0D};
          --offline  : var(--text-4);

          /* border colors */
          --border-light: var(--hover);
          --border: var(--active);
          --border-hover: var(--accent-1);
          --button-border: color-mix(in srgb, ${colors.base06} 10%, transparent);
      }
    '';
}
