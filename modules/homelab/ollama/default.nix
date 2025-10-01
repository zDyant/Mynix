{ config, lib, ... }:
let cfg = config.services."ollama-custom";
in {
  options.services."ollama-custom" = {
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
      openFirewall = true;
      port = cfg.port;
      acceleration = "rocm";
      loadModels = [ "llama3.1:8b" "deepseek-r1:7b" ];
    };

  };
}

