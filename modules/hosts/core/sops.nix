{ lib, flakeRoot, ...}:
{
  sops = {
    defaultSopsFile = lib.fs.relativeTo flakeRoot "secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = "/sops.txt";
  };
}
