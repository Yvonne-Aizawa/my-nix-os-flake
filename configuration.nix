# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page

{ config, pkgs, ... }:

let
  # Get the last working revision with nvidia 460.x
  nixos-unstable-pinned = import
    (builtins.fetchTarball {
      name = "nixos-unstable_nvidia-x11-470.57.02";
      url = https://github.com/nixos/nixpkgs/archive/03100da5a714a2b6c5210ceb6af092073ba4fce5.tar.gz;
      sha256 = "0bblrvhig7vwiq2lgjrl5ibil3sz7hj26gaip6y8wpd9xcjr3v7a";
    })
    { config.allowUnfree = true; };

  # We'll use this twice
  pinnedKernelPackages = nixos-unstable-pinned.linuxPackages_latest;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

    ];
  hardware.nvidia.modesetting.enable = true;
  programs.xwayland.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  # services.xserver.displayManager.gdm.nvidiaWayland = true;
  hardware.opengl.enable = true;
  # Install nvidia 460
  nixpkgs.config.packageOverrides = pkgs: {
    # Swap out all of the linux packages
    linuxPackages_latest = pinnedKernelPackages;
    # Make sure x11 will use the correct package as well
    nvidia_x11 = nixos-unstable-pinned.nvidia_x11;
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  #mount home drive
  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/30a1c83f-020f-490c-a7c8-f266223f779f";
      fsType = "ext4";
    };
  boot.initrd.luks.devices."luks-a280ec5a-cead-45d8-9f9a-2725885e79b3".device = "/dev/disk/by-uuid/a280ec5a-cead-45d8-9f9a-2725885e79b3";
  # Enable swap on luks
  boot.initrd.luks.devices."luks-84278170-4da9-48f5-895b-96bc1c3b9235".device = "/dev/disk/by-uuid/84278170-4da9-48f5-895b-96bc1c3b9235";
  boot.initrd.luks.devices."luks-84278170-4da9-48f5-895b-96bc1c3b9235".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "yvonne"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver = {
    videoDrivers = [
      "nvidia"
    ];
  };
  # Enable the KDE Plasma Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  # Enable Gnome Desktop Enviroment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yvonne = {
    isNormalUser = true;
    description = "yvonne";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      # packages are installed using home manager
    ];
  };
  # install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fuse
    fuse3
    appimage-run
    direnv
    git
    podman-compose
    rustup
    gcc
    openssl
    nixpkgs-fmt
      (callPackage ./mcontrolcenter.nix {})
  ];
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
    waydroid.enable = true;
    lxd.enable = true;

  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
    "qtwebkit-5.212.0-alpha4"
  ];
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
