{...}: {
  services.lact.enable = true;
  hardware = {
    amdgpu.overdrive.enable = true;
    amdgpu.opencl.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
