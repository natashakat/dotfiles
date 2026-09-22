{ config, pkgs, ... }:

{
  programs.thunderbird.enable = true;
  programs.freetube.enable = true;
  programs.keepassxc.enable = true;
  programs.prismlauncher.enable = true;

  xdg.configFile = {
    "kate/katerc".text = ''
    '';

    "mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/freetube=freetube.desktop
      x-scheme-handler/mo=motrix.desktop
      x-scheme-handler/motrix=motrix.desktop
      x-scheme-handler/magnet=motrix.desktop
    '';
  };
}
