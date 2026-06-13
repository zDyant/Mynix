{
  host,
  pkgs,
  lib,
  secrets,
  ...
}: let
  user = host.user;
  userSecrets = secrets.users.${user.name} or {};
in {
  users.users.${user.name} = {
    createHome = true;
    description = "Admin";
    homeMode = "750";
    hashedPassword = userSecrets.hashedPassword or null;
    openssh.authorizedKeys.keys = userSecrets.ssh.publicKeys or [];
  };

  # Special sudo config for user
  users.users.root = {
    shell = pkgs.nushell;
    hashedPassword = lib.mkForce (userSecrets.hashedPassword or null);
    openssh.authorizedKeys.keys = userSecrets.ssh.publicKeys or [];
  };

  security.sudo = {
    extraConfig = ''
      Defaults lecture = never
      Defaults pwfeedback
      Defaults timestamp_timeout=120
      Defaults env_keep+=SSH_AUTH_SOCK
    '';

    extraRules = [
      {
        users = [user.name];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
