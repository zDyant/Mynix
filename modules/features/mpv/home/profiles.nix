{
  pkgs,
  lib,
  ...
}:
# https://github.com/knoc-off/nixos/blob/fb4e8bb41b131edf4b8489ac2803aac65999f00f/home/programs/media/video/mpv.nix
# https://github.com/pope/personal/tree/d05593bfa85c8fa31757bf4637139bc7b49f3ce6/modules/home/mpv
{
  programs.mpv.profiles = let
    shadersPkg = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
    mkShaderProfile = {
      description,
      shaders,
      vo ? "gpu",
    }: {
      inherit vo;
      profile-desc = description;
      glsl-shaders = lib.concatStringsSep ":" (map (shader: "${shadersPkg}/${shader}") shaders);
    };
  in {
    fsr = mkShaderProfile {
      description = "AMD FSR 1.0 Upscaling";
      shaders = ["FSR.glsl"];
    };

    fsrcnnx = mkShaderProfile {
      description = "FSRCNNX Neural Network Upscaling";
      shaders = ["FSRCNNX_x2_16-0-4-1.glsl"];
    };

    nis = mkShaderProfile {
      description = "NVIDIA Image Scaling (all GPUs)";
      shaders = ["NVScaler.glsl"];
    };

    anime4k = mkShaderProfile {
      description = "Anime4K Upscaling (Mode A)";
      shaders = [
        "Anime4K_Denoise_Bilateral_Mode.glsl"
        "Anime4K_Thin_HQ.glsl"
        "Anime4K_Upscale_Denoise_CNN_x2_M.glsl"
      ];
    };

    "rescale-balanced" = mkShaderProfile {
      description = "Fix bad upscales with a balanced Anime4K chain. (Good start)";
      shaders = [
        # Downscale 1080p -> 540p to remove upscaling artifacts
        "Anime4K_AutoDownscalePre_x2.glsl"
        # Upscale, denoise, and deblur in one step
        "Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"
        # Optional line art sharpening
        "Anime4K_Darken_HQ.glsl"
        "Anime4K_Thin_HQ.glsl"
      ];
    };

    "rescale-hq" = mkShaderProfile {
      description = "Fix bad upscales with Restore + FSRCNNX. (Recommended Quality)";
      shaders = [
        # Downscale 1080p -> 540p to remove upscaling artifacts
        "Anime4K_AutoDownscalePre_x2.glsl"
        # Powerful restoration shader for artifacts and noise
        "Anime4K_Restore_CNN_VL.glsl"
        # High-quality neural network upscaler
        "FSRCNNX_x2_16-0-4-1.glsl"
        # Final contrast-adaptive sharpening pass
        "CAS-scaled.glsl"
      ];
    };

    "rescale-nnedi3" = mkShaderProfile {
      description = "Fix bad upscales with nnedi3. (Very High Quality, gpu-next only)";
      vo = "gpu-next";
      shaders = [
        # Downscale 1080p -> 540p
        "Anime4K_AutoDownscalePre_x2.glsl"
        # Restore artifacts before upscaling
        "Anime4K_Restore_CNN_M.glsl"
        # High-quality luma upscaler, great for lines
        "nnedi3-nns64-win8x6.hook"
      ];
    };
  };
}
