{inputs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.nur.modules.nixos.default
    inputs.bonk.nixosModules.default
    ./config
  ];
}
