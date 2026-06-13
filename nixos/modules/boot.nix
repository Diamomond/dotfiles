{ config, pkgs, inputs, ... }:

{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.kernelParams = [
    "zswap.enabled=1" # enables zswap
    "zswap.compressor=zstd" # compression algorithm
    "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
    "zswap.shrinker_enabled=1"# whether to shrink the pool proactively on high memory pressure
    "i8042.nopnp"
    "i8042.direct"
    "i8042.reset"
  ];
  

hardware.bluetooth.enable=true;
hardware.enableAllFirmware=true;
#services.displayManager.gdm.wayland = false;
services.displayManager={
  gdm.enable=true;
  defaultSession="niri";
    autoLogin={
      enable=true;
      user="lukas";
       };
    };
}
