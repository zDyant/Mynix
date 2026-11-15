{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.omp.nixosModules.default];
  programs.omp.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;

    loadModels = [
      "qwen3.5:9b"
    ];

    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "15m";
      OLLAMA_FLASH_ATTENTION = "1";
    };
  };
}
