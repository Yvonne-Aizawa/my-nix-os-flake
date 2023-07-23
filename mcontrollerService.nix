{ config, lib, pkgs, ... }:

{
  options.services.mcontrolcenter-helperService = {
    enable = lib.mkEnableOption "mcontrolcenter-helper service";

    user = lib.mkOption {
      type = lib.types.str;
      default = "root";
      description = "User account under which mcontrolcenter-helper service should run.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "root";
      description = "Group under which mcontrolcenter-helper service should run.";
    };
  };

  config = lib.mkIf config.services.mcontrolcenter-helperService.enable {
    systemd.services.mcontrolcenter-helperService = {
      description = "My mcontrolcenter-helper Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.mcontrolcenter}/bin/mcontrolcenter-helper";
        User = config.services.mcontrolcenter-helperService.user;
        Group = config.services.mcontrolcenter-helperService.group;
      };
    };
  };
}
