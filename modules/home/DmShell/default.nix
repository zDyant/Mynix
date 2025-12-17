{ inputs, ... }: {
  imports = [ inputs.dms.homeModules.dankMaterialShell.default ];
  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
    systemd.restartIfChanged = true;
  };
}
