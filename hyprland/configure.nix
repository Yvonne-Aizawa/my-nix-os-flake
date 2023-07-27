{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # XDG portal
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };
  security.pam.services.gtklock = {};

  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      enable = true;
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  # need to run this manually
  # systemctl start --user polkit-kde-authentication-agent-1.service
  # also cant open display
}
