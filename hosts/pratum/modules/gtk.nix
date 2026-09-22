{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "MacTahoe-dark";
    iconTheme.name = "MacTahoe-dark";
    cursorTheme.name = "MacTahoe-dark";
    cursorTheme.size = 24;
    fontName = "Noto Sans, 10";
  };

  xdg.configFile = {
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=false
      gtk-button-images=true
      gtk-cursor-blink=true
      gtk-cursor-blink-time=1000
      gtk-cursor-theme-name=MacTahoe-dark
      gtk-cursor-theme-size=24
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-font-name=Noto Sans, 10
      gtk-icon-theme-name=MacTahoe-dark
      gtk-menu-images=true
      gtk-modules=colorreload-gtk-module
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-toolbar-style=3
      gtk-xft-dpi=98304
    '';

    "gtkrc-2.0".text = ''
      gtk-enable-animations=1
      gtk-theme-name=""
      gtk-primary-button-warps-slider=1
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-blink-time=1000
      gtk-cursor-blink=1
      gtk-cursor-theme-size=24
      gtk-cursor-theme-name="MacTahoe-dark"
      gtk-sound-theme-name=ocean
      gtk-icon-theme-name=MacTahoe-dark
      gtk-font-name=Noto Sans,  10
    '';
  };
}
