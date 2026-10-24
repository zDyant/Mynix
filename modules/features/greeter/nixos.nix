{
  lib,
  host,
  ...
}: {
  services.displayManager.dux-greeter = {
    enable = true;
    compositor.name = lib.mkDefault "hyprland";
    configHome = lib.mkDefault "/home/${host.user.name}";
  };
}
