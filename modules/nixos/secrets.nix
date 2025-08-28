{ pkgs, inputs, config, ...}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/zdyant/.config/sops/age/keys.txt";

  sops.secrets.gemini_api_key = {
    owner = config.users.users.zdyant.name;
  };
}
