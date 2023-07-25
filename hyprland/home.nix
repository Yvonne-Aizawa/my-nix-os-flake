{xdg,pkgs, ...}:
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

}
