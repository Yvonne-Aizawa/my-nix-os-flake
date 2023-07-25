{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.waybar
    pkgs.dunst
    pkgs.wofi
    pkgs.libnotify
    pkgs.swww
    pkgs.kitty
    pkgs.polkit_gnome
    pkgs.xdg-desktop-portal-gtk
    pkgs.sway-contrib.grimshot
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
  ];
}
