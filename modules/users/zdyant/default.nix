{
  lib,
  host,
  ...
}: {
  imports = lib.optionals (!host.isMinimal) (lib.fs.scanPaths ./.);
}
