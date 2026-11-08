{
  host,
  lib,
  ...
}: {
  security.sudo = {
    extraConfig = ''
      Defaults rootpw
      Defaults timestamp_timeout=15
      Defaults:${host.user.name} env_keep -= "SSH_AUTH_SOCK"
    '';
    extraRules = lib.mkAfter [
      {
        users = [host.user.name];
        commands = [
          {
            command = "ALL";
            options = ["PASSWD"];
          }
        ];
      }
    ];
  };
}
