{ ... }:
{
  services.open-webui = {
    enable = true;
    openFirewall = true;
    port = 45555;
    environment = {
      WEBUI_AUTH = "False";
    };
  };

  services.ollama = {
    enable = true;
    openFirewall = true;
  };

}
