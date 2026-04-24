{ pkgs, ... }:
# https://github.com/knoc-off/nixos/blob/fb4e8bb41b131edf4b8489ac2803aac65999f00f/home/programs/media/video/mpv.nix
# https://github.com/pope/personal/tree/d05593bfa85c8fa31757bf4637139bc7b49f3ce6/modules/home/mpv
{
  programs.mpv.profiles =
    let
      shadersPkg = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
    in
    {
      fsr = {
        "profile-desc" = "AMD FSR 1.0 Upscaling";
        "glsl-shaders" = [ "${shadersPkg}/FSR.glsl" ];
        "glsl-shader-opts" = [ "fsr-strength=0" ];
      };

      fsrcnnx = {
        "profile-desc" = "FSRCNNX Neural Network Upscaling";
        "glsl-shaders" = [ "${shadersPkg}/FSRCNNX_x2_16-0-4-1.glsl" ];
      };

      nis = {
        "profile-desc" = "NVIDIA Image Scaling (all GPUs)";
        "glsl-shaders" = [ "${shadersPkg}/NVScaler.glsl:scale-sharpness=0.5" ];
      };

      anime4k = {
        "profile-desc" = "Anime4K Upscaling (Mode A)";
        "glsl-shaders" = [
          "${shadersPkg}/Anime4K_Denoise_Bilateral_Mode.glsl"
          "${shadersPkg}/Anime4K_Thin_HQ.glsl"
          "${shadersPkg}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl"
        ];
      };

      "rescale-balanced" = {
        "profile-desc" = "Fix bad upscales with a balanced Anime4K chain. (Good start)";
        "glsl-shaders" = [
          # Downscale 1080p -> 540p to remove upscaling artifacts
          "${shadersPkg}/Anime4K_AutoDownscalePre_x2.glsl"
          # Upscale, denoise, and deblur in one step
          "${shadersPkg}/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"
          # Optional line art sharpening
          "${shadersPkg}/Anime4K_Darken_HQ.glsl"
          "${shadersPkg}/Anime4K_Thin_HQ.glsl"
        ];
      };

      "rescale-hq" = {
        "profile-desc" = "Fix bad upscales with Restore + FSRCNNX. (Recommended Quality)";
        "glsl-shaders" = [
          # Downscale 1080p -> 540p to remove upscaling artifacts
          "${shadersPkg}/Anime4K_AutoDownscalePre_x2.glsl"
          # Powerful restoration shader for artifacts and noise
          "${shadersPkg}/Anime4K_Restore_CNN_VL.glsl"
          # High-quality neural network upscaler
          "${shadersPkg}/FSRCNNX_x2_16-0-4-1.glsl"
          # Final contrast-adaptive sharpening pass
          "${shadersPkg}/CAS-scaled.glsl"
        ];
      };

      "rescale-nnedi3" = {
        "profile-desc" = "Fix bad upscales with nnedi3. (Very High Quality, gpu-next only)";
        # WARN: This profile requires vo=gpu-next to be set in your main config
        vo = "gpu-next";
        "glsl-shaders" = [
          # Downscale 1080p -> 540p
          "${shadersPkg}/Anime4K_AutoDownscalePre_x2.glsl"
          # Restore artifacts before upscaling
          "${shadersPkg}/Anime4K_Restore_CNN_M.glsl"
        ];
        "hook-shaders" = [
          # High-quality luma upscaler, great for lines
          "${shadersPkg}/nnedi3-nns64-win8x6.hook"
        ];
      };

    };
}
