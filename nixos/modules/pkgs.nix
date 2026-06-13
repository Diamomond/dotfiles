{ config, pkgs, inputs,lib, ... }:

{
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true; 

  environment.systemPackages = with pkgs; [
  
  #system packages
  wget
 jq
 git
 fastfetch
 alacritty
 kitty
 eog 
 xwayland-satellite
 fuzzel
 mako
 xdg-desktop-portal-gtk
 xdg-desktop-portal-gnome
 xdg-user-dirs
 rose-pine-cursor
 adw-gtk3
 gtk3
 adwaita-icon-theme
 gsettings-desktop-schemas
 glib
 file-roller
 nwg-look
 btop
 ncdu
 p7zip
 ntfs3g
 wtype
 filezilla
 protontricks
 ffmpeg
 nvtopPackages.amd
 yt-dlp
 proton-vpn
 gparted
 easyeffects
 wine
 pywalfox-native
 nautilus
 gnome-keyring
 gsettings-desktop-schemas
 inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
 #cloudflare-warp
 #kdePackages.qttools
  
  #university/productivity
 obsidian
 handy
 stirling-pdf-desktop
 collabora-desktop
 zotero
 gedit
 vscode
 foliate
 zathura
 lmstudio 
 
 #media stuff
 calibre
 qbittorrent
 pkgs.davinci-resolve
 ani-cli
 mpv
 mpvScripts.convert
 equibop
 discord
 audacity
 mpvpaper
 gpu-screen-recorder
 nicotine-plus
 strawberry
 makemkv
 asunder
 mangayomi
 sly
 handbrake
 krita

  ];

}
