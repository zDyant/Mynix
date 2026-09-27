{inputs, ...}: {
  imports = [inputs.play.nixosModules.play];

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };
  play = {
    amd.enable = true;
    ananicy.enable = true;
    gamemode.enable = true;
    steam.enable = true;
    steam.millennium.enable = true;
    heroic.enable = true;
  };
}
