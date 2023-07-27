{ xdg, pkgs, ... }:
{
  xdg.enable = true;
  xdg.configFile."/.config/dunst/dunstrc" = {
    source = ../home/dunst/dunstrc;
  };
  xdg.configFile."/.config/hypr/hyprland.conf" = {
    source = ../home/hyprland/hyprland.conf;
  };
  xdg.configFile."/.config/hypr/reload.bash" = {

    source = ../home/hyprland/reload.bash;

  };
  xdg.configFile."/.config/waybar/config" = {
    source = ../home/waybar/config;
  };
  xdg.configFile."/.config/waybar/style.css" = {
    source = ../home/waybar/style.css;
  };
  xdg.configFile."/.config/waybar/bar.png" = {
    source = ../home/waybar/bar.png;
  };
  xdg.configFile."/.config/waybar/start.png" = {
    source = ../home/waybar/start.png;
  };
  xdg.configFile."/.config/waybar/arrow.png" = {
    source = ../home/waybar/arrow.png;
  };

  xdg.configFile."/.config/wlogout/" = {
    source = ../home/wlogout;
    recursive = true;
  };



}
