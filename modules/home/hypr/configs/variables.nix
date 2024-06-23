{ ... }:
{
wayland.windowManager.hyprland = {
  extraConfig = "

env = CLUTTER_BACKEND,wayland
env = GDK_BACKEND,wayland,x11
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = QT_QPA_PLATFORM,wayland;xcb
env = QT_QPA_PLATFORMTHEME,qt5ct  
env = QT_SCALE_FACTOR,1
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland

# !!!!!!!!!!!
# vulkan
# env = WLR_RENDERER,vulkan  # KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH

# firefox
env = MOZ_ENABLE_WAYLAND,1

# FOR VM and POSSIBLY NVIDIA
#env = WLR_RENDERER_ALLOW_SOFTWARE,1

# nvidia firefox (for hardware acceleration on FF)?
# check this post https://github.com/elFarto/nvidia-vaapi-driver#configuration
#env = MOZ_DISABLE_RDD_SANDBOX,1
#env = NVD_BACKEND,direct
#env = EGL_PLATFORM,wayland
    ";
  };
}
