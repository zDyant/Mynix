{
  inputs,
  pkgs,
  ...
}: {
  # Import the upstream PipeWire stack and tools directly. Its shared module
  # currently defines removed systemd.user.extraConfig, so keep that common
  # configuration here with the supported systemd.user.settings option.
  imports = [
    (inputs.audio.outPath + "/pipewire.nix")
    (inputs.audio.outPath + "/device-rules.nix")
    inputs.audio.nixosModules.tools
  ];

  security.rtkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "nice";
      type = "-";
      value = "-19";
    }
  ];

  systemd.settings.Manager = {
    DefaultLimitRTPRIO = 95;
    DefaultLimitNICE = "-19";
  };
  systemd.user.settings.Manager = {
    DefaultLimitRTPRIO = 95;
    DefaultLimitNICE = "-19";
  };

  services.pulseaudio.enable = false;
  environment.systemPackages = with pkgs; [
    playerctl
    pulseaudio
  ];
}
