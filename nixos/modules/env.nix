{ config, pkgs, inputs, ... }:

{
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
    XCURSOR_SIZE = "26";
    XCURSOR_THEME = "BreezeX-RosePine-Linux";
  };

 environment.variables = rec {
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  }; 

  environment.sessionVariables={
  XDG_CURRENT_DESKTOP = "niri";
  XDG_SESSION_TYPE = "wayland";
  NIXOS_OZONE_WL = "1";
QT_QPA_PLATFORMTHEME = "gtk3";
  };

environment.etc."mozilla/native-messaging-hosts/pywalfox.json".text = ''
  {
    "name": "pywalfox",
    "description": "Pywalfox native messaging host",
    "path": "${pkgs.pywalfox-native}/bin/pywalfox",
    "type": "stdio",
    "allowed_extensions": ["pywalfox@frewacom.org"]
  }
'';

}
