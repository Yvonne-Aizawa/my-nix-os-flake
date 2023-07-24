{
   systemd.services.mcontrolcenter-helper = {
      wantedBy = [ "multi-user.target" ]; 
      after = [ "network.target" ];
      description = "pls";
      serviceConfig = {
        User = "root";
        ExecStart = ''/run/current-system/sw/bin/mcontrolcenter-helper'';         
      };
   };
 
}
