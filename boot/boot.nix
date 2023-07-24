{pkgs, ...}:
{
  # boot.plymouth = {
  #   enable = true;
  #   theme = "breeze";
  # };

  boot.initrd.kernelModules = [ "ec_sys" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # boot.plymouth.enable = true;
  boot.kernelParams = [ "splash" ];
  boot.loader.efi.canTouchEfiVariables = true;
  #mount home drive

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
}

