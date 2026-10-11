{
  config,
  lib,
  pkgs,
  ...
}: let
  homelab = config.homelab;
  cfg = homelab.services."ollama";
in {
  options.homelab.services."ollama" = {
    enable = lib.mkEnableOption "Custom Ollama configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Ollama bind address";
      default = 11434;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      port = cfg.port;
      package = lib.mkDefault pkgs.ollama-vulkan;
      environmentVariables = {
        # Ryzen 5 5600 / 9060xt 16gb
        OLLAMA_FLASH_ATTENTION = lib.mkDefault "1";
        OLLAMA_MAX_LOADED_MODELS = lib.mkDefault "2";
        loadModels = lib.mkDefault [
          "qwen3.5:9b"
        ];
      };
    };
  };
}
