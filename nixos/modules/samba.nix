{ pkgs, config, ... }: {

services.samba = {
    # The full package is needed to register mDNS records (for discoverability), see discussion in
    # https://gist.github.com/vy-let/a030c1079f09ecae4135aebf1e121ea6
    #package = pkgs.samba4Full;
    usershares.enable = true;
    enable = true;
    nmbd.enable = true;
    winbindd.enable = false;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "NixOS Samba Server";
        "netbios name" = "nixos-share";
        "security" = "user";

        "local master" = "no";
        "preferred master" = "no";
        "domain master" = "no";
        "os level" = "0";
        # macOS specific optimizations (vfs_fruit)
        # Handles AppleDouble files, resource forks, and improves Finder performance
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:aapl" = "yes";
        "fruit:model" = "MacSamba"; # Makes the server show up with a Mac icon
        "fruit:veto_appledouble" = "no";
        "fruit:posix_rename" = "yes";
        "fruit:zero_file_id" = "yes";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:delete_empty_adfiles" = "yes";
      };

      "Music" = {
        "path" = "/home/lukas/Music";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "lukas";
        "force user" = "lukas";
      };


      "Documents" = {
        "path" = "/home/lukas/Documents/";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "lukas";
        "force user" = "lukas";
      };

      "Pictures" = {
        "path" = "/home/lukas/Pictures";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "lukas";
        "force user" = "lukas";
      };

      "Videos" = {
        "path" = "/home/lukas/Videos";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "lukas";
        "force user" = "lukas";
      };
    };
  };
  # Enable Avahi (mDNS/Bonjour) so the Mac automatically discovers the share
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

}
