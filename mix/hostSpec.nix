{lib, ...}: {
  options.isMinimal = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
}
