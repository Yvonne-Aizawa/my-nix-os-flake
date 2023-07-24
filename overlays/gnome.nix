{pkgs, ...}:
{
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
]) ++ (with pkgs.gnome; [
  gnome-terminal
  gnome-characters
  totem # video player
]);
}