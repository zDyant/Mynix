{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices.disk = {
    os = {
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_118718849";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            type = "EF02";
            size = "1M";
            priority = 1;
          };
          ESP = {
            type = "EF00";
            size = "512M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };

    block = {
      device = "/dev/disk/by-id/scsi-0HC_Volume_105748237";
      type = "disk";

      content = {
        type = "gpt";

        partitions = {
          nix = {
            size = "100%";

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
        };
      };
    };
  };
}
