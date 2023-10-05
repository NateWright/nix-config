{ config, pkgs, ... }: {
    services.snapper.configs = {
        root = {
            SUBVOLUME = "/";
            ALLOW_USERS = [ "root" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
        };
        home = {
            SUBVOLUME = "/home";
            ALLOW_USERS = [ "root" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
        };

    };
}