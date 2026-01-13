{ config, ... }: {
  programs.nixcord.quickCss = ''
        /*
         * @name system24
         * @description a tui-style discord theme.
         * @author refact0r
         * @version 2.0.0
         * @invite nz87hXyvcy
         * @website https://github.com/refact0r/system24
         * @source https://github.com/refact0r/system24/blob/master/theme/system24.theme.css
         * @authorId 508863359777505290
         * @authorLink https://www.refact0r.dev
        */

        /* import theme modules */
        @import url('https://refact0r.github.io/system24/build/system24.css');

        body {
            --font: 'DM Mono'; /* change to ' ' for default discord font */
            --code-font: 'DM Mono'; /* change to ' ' for default discord font */
            font-weight: 300; /* text font weight. 300 is light, 400 is normal. DOES NOT AFFECT BOLD TEXT */
            letter-spacing: -0.05ch; /* decreases letter spacing for better readability. recommended on monospace fonts.*/

            /* sizes */
            --gap: 12px; /* spacing between panels */
            --divider-thickness: 4px; /* thickness of unread messages divider and highlighted message borders */
            --border-thickness: 1px; /* thickness of borders around main panels. DOES NOT AFFECT OTHER BORDERS */
            --border-hover-transition: 0.2s ease; /* transition for borders when hovered */

            /* animation/transition options */
            --animations: on; /* off: disable animations/transitions, on: enable animations/transitions */
            --list-item-transition: 0.4s ease; /* transition for list items */
            --dms-icon-svg-transition: 0.6s ease; /* transition for the dms icon */

            /* top bar options */
            --top-bar-height: var(--gap); /* height of the top bar (discord default is 36px, old discord style is 24px, var(--gap) recommended if button position is set to titlebar) */
            --top-bar-button-position: titlebar; /* off: default position, hide: hide buttons completely, serverlist: move inbox button to server list, titlebar: move inbox button to channel titlebar (will hide title) */
            --top-bar-title-position: off; /* off: default centered position, hide: hide title completely, left: left align title (like old discord) */
            --subtle-top-bar-title: off; /* off: default, on: hide the icon and use subtle text color (like old discord) */

            /* window controls */
            --custom-window-controls: on; /* off: default window controls, on: custom window controls */
            --window-control-size: 14px; /* size of custom window controls */

            /* dms button options */
            --custom-dms-icon: off; /* off: use default discord icon, hide: remove icon entirely, custom: use custom icon */
            --dms-icon-svg-url: url(""); /* icon svg url. MUST BE A SVG. */
            --dms-icon-svg-size: 90%; /* size of the svg (css mask-size property) */
            --dms-icon-color-before: var(--icon-secondary); /* normal icon color */
            --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */
            --custom-dms-background: off; /* off to disable, image to use a background image (must set url variable below), color to use a custom color/gradient */
            --dms-background-image-url: url(""); /* url of the background image */
            --dms-background-image-size: cover; /* size of the background image (css background-size property) */
            --dms-background-color: linear-gradient(70deg, var(--blue), var(--purple), var(--red)); /* fixed color/gradient (css background property) */

            /* background image options */
            --background-image: off; /* off: no background image, on: enable background image (must set url variable below) */
            --background-image-url: url(""); /* url of the background image */

            /* transparency/blur options */
            /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
            --transparency-tweaks: off; /* off: no changes, on: remove some elements for better transparency */
            --remove-bg-layer: off; /* off: no changes, on: remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
            --panel-blur: off; /* off: no changes, on: blur the background of panels */
            --blur-amount: 12px; /* amount of blur */
            --bg-floating: var(--bg-3); /* set this to a more opaque color if floating panels look too transparent. only applies if panel blur is on  */

            /* other options */
            --small-user-panel: on; /* off: default user panel, on: smaller user panel like in old discord */

            /* unrounding options */
            --unrounding: on; /* off: default, on: remove rounded corners from panels */

            /* styling options */
            --custom-spotify-bar: on; /* off: default, on: custom text-like spotify progress bar */
            --ascii-titles: on; /* off: default, on: use ascii font for titles at the start of a channel */
            --ascii-loader: system24; /* off: default, system24: use system24 ascii loader, cats: use cats loader */

            /* panel labels */
            --panel-labels: on; /* off: default, on: add labels to panels */
            --label-color: var(--text-muted); /* color of labels */
            --label-font-weight: 500; /* font weight of labels */
        }

      :root {
        --colors: on;

        /* text colors */
        --text-0: ${config.lib.stylix.colors.withHashtag.base01};
        --text-1: ${config.lib.stylix.colors.withHashtag.base05};
        --text-2: ${config.lib.stylix.colors.withHashtag.base06};
        --text-3: ${config.lib.stylix.colors.withHashtag.base04};
        --text-4: ${config.lib.stylix.colors.withHashtag.base03};
        --text-5: ${config.lib.stylix.colors.withHashtag.base07};

        /* background colors (dark → light) */
        --bg-4: ${config.lib.stylix.colors.withHashtag.base00};
        --bg-3: ${config.lib.stylix.colors.withHashtag.base01};
        --bg-2: ${config.lib.stylix.colors.withHashtag.base02};
        --bg-1: ${config.lib.stylix.colors.withHashtag.base03};

        /* hover + active */
        --hover: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base05} 10%, transparent);
        --active: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base05} 20%, transparent);
        --active-2: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base05} 30%, transparent);
        --message-hover: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base05} 10%, transparent);

        /* accent colors */
        --accent-1: ${config.lib.stylix.colors.withHashtag.base0A}; /* links */
        --accent-2: ${config.lib.stylix.colors.withHashtag.base0D}; /* UI accents */
        --accent-3: ${config.lib.stylix.colors.withHashtag.base0D};
        --accent-4: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base0D} 80%, white);
        --accent-5: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base0D} 70%, white);

        --accent-new: ${config.lib.stylix.colors.withHashtag.base08}; /* red-like */

        --mention: linear-gradient(
            to right,
            color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base0D} 10%, transparent) 40%,
            transparent
        );
        --mention-hover: linear-gradient(
            to right,
            color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base0D} 5%, transparent) 40%,
            transparent
        );

        --reply: linear-gradient(
            to right,
            color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base04} 10%, transparent) 40%,
            transparent
        );
        --reply-hover: linear-gradient(
            to right,
            color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base04} 5%, transparent) 40%,
            transparent
        );

        /* status indicator colors */
        --online   : var(--green );
        --dnd      : var(--red);
        --idle     : var(--yellow);
        --streaming: var(--purple);
        --offline  : var(--text-4);

        /* borders */
        --border-light: var(--hover);
        --border: var(--active);
        --border-hover: var(--accent-1);
        --button-border: color-mix(in srgb, ${config.lib.stylix.colors.withHashtag.base06} 10%, transparent);

        /* base semantic colors */
        --red:    ${config.lib.stylix.colors.withHashtag.base08};
        --green:  ${config.lib.stylix.colors.withHashtag.base0C};
        --blue:   ${config.lib.stylix.colors.withHashtag.base0B};
        --yellow: ${config.lib.stylix.colors.withHashtag.base0E};
        --purple: ${config.lib.stylix.colors.withHashtag.base0D};
    }
  '';
}
