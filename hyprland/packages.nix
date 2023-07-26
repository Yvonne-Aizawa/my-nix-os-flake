{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.waybar
    pkgs.dunst
    pkgs.wofi
    pkgs.libnotify
    pkgs.swww
    pkgs.kitty
    pkgs.polkit-kde-agent
    pkgs.xdg-desktop-portal-hyprland
    pkgs.sway-contrib.grimshot
    pkgs.xorg.xhost
    pkgs.udiskie
    pkgs.hyprpicker
    pkgs.pamixer
    pkgs.pavucontrol
    pkgs.wl-clipboard
    pkgs.networkmanagerapplet
    pkgs.ponymix
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
  ];
}
