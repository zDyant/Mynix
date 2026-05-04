{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    openFirewall = true;
    package = pkgs.ollama-vulkan;
    environmentVariables = {
      # Ryzen 5 5600 / 9060xt 16gb
      OLLAMA_NUM_THREADS="12";
      OLLAMA_FLASH_ATTENTION="1";
      OLLAMA_MAX_LOADED_MODELS = "2";
    };
    loadModels = [
      "qwen3.5:9b"
      "sweepai/sweep-next-edit:latest"
    ];
  };
}
