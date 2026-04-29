{ host, lib, ... }: {
  # https://git.ryot.foo/toph/dot.nix/src/branch/main/modules/hosts/core/networking.nix#
  # Essential WireGuard setup when any WireGuard-dependent service is enabled
  config = lib.mkMerge [
    # Base networking configuration
    {
      networking = {
        dhcpcd.enable = false;
        hostName = host.hostName;
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
        useHostResolvConf = false;
        usePredictableInterfaceNames = true;
      };
    }
  ];
}
