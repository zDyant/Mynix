{
  lib,
  host,
  ...
}: {
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = lib.mkDefault "hyprland";
    configHome = lib.mkDefault "/home/${host.user.name}";
  };
}
