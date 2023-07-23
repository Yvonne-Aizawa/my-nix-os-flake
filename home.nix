{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "yvonne";
  home.homeDirectory = "/home/yvonne";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # tools
    htop
    gnome.gnome-disk-utility
    mangohud
    yubikey-manager-qt
    proton-caller
    virt-manager

    #customization
    gnome-extension-manager
    gnome3.gnome-tweaks
    eww-wayland

    #develoment
    vscode
    podman-desktop
    beekeeper-studio
    github-desktop
    distrobox
    ubports-click

    # entertainment
    firefox
    discord
    steam
    obs-studio

    signal-desktop
    whatsapp-for-linux
    telegram-desktop

    ## extensions
    gnomeExtensions.openweather
    gnomeExtensions.task-widget

    # productivity
    onlyoffice-bin
    obsidian


  ];

  programs.git = {
    enable = true;
    userName = "yvonne-aizawa";
    userEmail = "nixos@sl.yvonnetake.nl";
  };
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
