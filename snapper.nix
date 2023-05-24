{ config, pkgs, ... }: {
    services.snapper.configs = {
        root = {
            subvolume = "/";
            extraConfig = ''
                ALLOW_USERS="root"
                TIMELINE_CREATE=yes
                TIMELINE_CLEANUP=yes
            '';
        };
        home = {
            subvolume = "/home";
            extraConfig = ''
                ALLOW_USERS="root"
                TIMELINE_CREATE=yes
                TIMELINE_CLEANUP=yes
            '';
        };

    };
}