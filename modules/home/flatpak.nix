{ inputs, ... }: 
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.github.tchx84.Flatseal"
  ];

  # WARN Only affects user's installations, not system's
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };

  services.flatpak.overrides = {
    global = {
      # Force Wayland by default
      Context.sockets = ["wayland" "!x11" "!fallback-x11"];

      Environment = {
        # Fix un-themed cursor in some Wayland apps
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

        # Force correct theme for some GTK apps
        GTK_THEME = "Adwaita:dark";
      };
    };
  };
}
