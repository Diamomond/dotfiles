{ config, pkgs, inputs, ... }:

{


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
	ohMyZsh = {
     	 enable = true;
      	plugins = [
     	   "git"
     	   "z"
   	   ];
   	   theme = "robbyrussell";
 	   };
    shellAliases = {
      ll = "ls -l";
      cam = "ffplay -f video4linux2 -i /dev/video0 -vf 'hflip' ";
      edit = "sudo -e";
      rebuild = "sudo nixos-rebuild boot --flake /etc/nixos/";
      fu = "sudo nix flake update --flake /etc/nixos/";
      fetch = "fastfetch";
      fur = "sudo nix flake update --flake /etc/nixos/ && sudo nixos-rebuild boot --flake /etc/nixos/";
      music="mpv --vo=null --video=no --no-video --term-osd-bar --no-resume-playback --loop-playlist=inf --shuffle *";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

}
