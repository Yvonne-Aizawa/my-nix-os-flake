{ config, pkgs, ... }:

{
  #   xdg.mimeApps = {
  #   enable = true;

  #   defaultApplications = {
  #     "text/html" = "firefox.desktop";
  #     "text/xml" = "firefox.desktop";
  #     "application/xhtml_xml" = "firefox.desktop";
  #     "image/webp" = "firefox.desktop";
  #     "x-scheme-handler/http" = "firefox.desktop";
  #     "x-scheme-handler/https" = "firefox.desktop";
  #     "x-scheme-handler/ftp" = "firefox.desktop";
  #   };
  # };
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "yvonne";
  home.homeDirectory = "/home/yvonne";
  imports = [
    ./hyprland/home.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # tools
    htop
    gnome.gnome-disk-utility
    mangohud
    yubikey-manager-qt
    yubioath-flutter
    proton-caller
    virt-manager
    yubikey-touch-detector

    #customization
    # gnome-extension-manager
    # gnome3.gnome-tweaks
    

    #develoment
    vscode
    pods
    beekeeper-studio
    github-desktop
    distrobox
    ubports-click
    insomnia


    #nix development
    statix

    # entertainment
    firefox
    chromium
    # discord
    webcord-vencord
    steam
    obs-studio
    brave
    bitwarden
    signal-desktop
    whatsapp-for-linux
    telegram-desktop
    minecraft
    gimp

    # # Gnome extensions
    # gnomeExtensions.openweather
    # gnomeExtensions.task-widget
    # gnomeExtensions.tray-icons-reloaded
    # gnomeExtensions.just-perfection
    # gnomeExtensions.gnome-bedtime
    # gnomeExtensions.vitals
    # gnomeExtensions.top-bar-organizer
    # gnomeExtensions.syncthing-icon

    #hyprland
    # syncthingtray
    # productivity
    onlyoffice-bin
    obsidian
    syncthing
    home-manager


  ];
  # if extensions are disabled run
  # gsettings set org.gnome.shell disable-user-extensions false
  # home.file.".config/eww/" = {
  #   source = ./modules/eww/files;
  #   # recursive = true;
  # };

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
  services.syncthing.enable = true;
  # services.yubikey-touch-detector.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
