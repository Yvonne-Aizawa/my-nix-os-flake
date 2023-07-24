{
  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/30a1c83f-020f-490c-a7c8-f266223f779f";
      fsType = "ext4";
    };
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.initrd.luks.devices."luks-a280ec5a-cead-45d8-9f9a-2725885e79b3".device = "/dev/disk/by-uuid/a280ec5a-cead-45d8-9f9a-2725885e79b3";
  # Enable swap on luks
  boot.initrd.luks.devices."luks-84278170-4da9-48f5-895b-96bc1c3b9235".device = "/dev/disk/by-uuid/84278170-4da9-48f5-895b-96bc1c3b9235";
  boot.initrd.luks.devices."luks-84278170-4da9-48f5-895b-96bc1c3b9235".keyFile = "/crypto_keyfile.bin";
}
