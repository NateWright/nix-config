{ config, pkgs, ... }:

{

    # Samba 
    services.samba-wsdd.enable = true;
    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 5537 ];
    networking.firewall.interfaces."tailscale0".allowedUDPPorts = [ 3702 ];

    services.samba = {
        enable = true;
        securityType = "user";
        shares.public = {
            path = "/vault/smb";
            writeable = "yes";
            browseable = "yes";
        };
        shares.test = {
            path = "/vault/test";
            browseable = "yes";
            "read only" = "no";
            "guest ok" = "no";
            "create mask" = "0644";
            "directory mask" = "0775";
        };
        shares.global = {
            "server min protocol" = "SMB2_02";
        };
    };
    
}
