{ config, pkgs, inputs, ... }:

{

  programs.steam = {
	enable=true;
	gamescopeSession.enable=true;
  };
  programs.gamemode.enable=true; 
  programs.gamescope={
  	enable=true;
  };

  hardware.bluetooth.enable=true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics={
	enable=true;
	enable32Bit=true;
        extraPackages = with pkgs; [
          mesa.opencl
	  rocmPackages.clr.icd
    ];
  };


  environment.systemPackages = with pkgs; [
 protonup-qt
 #bottles
 (heroic.override {
  extraPkgs = pkgs': with pkgs'; [
    gamescope
    gamemode
  ];
})
 (prismlauncher.override{ additionalLibs=[libvlc];})
 azahar
 pcsx2
 ryubing
 xivlauncher
 osu-lazer-bin
 inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.default
  ];

}
