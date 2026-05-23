{ lib, ... }:
{
  programs.ssh.startAgent = true;

  # services.fail2ban.enable = true;
  services = {
    openssh = {
      enable = true;
      openFirewall = true;
      ports = [ 22 ];

      settings = {
        AllowUsers = null; # everyone
        PasswordAuthentication = lib.mkDefault false;
        PermitRootLogin = lib.mkDefault "no";
        KbdInteractiveAuthentication = false;
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
      };
    };
    gnome.gcr-ssh-agent.enable = false;
  };

}
