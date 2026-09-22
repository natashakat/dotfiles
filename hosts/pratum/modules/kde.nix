{ config, pkgs, ... }:

{
  xdg.configFile = {
    "plasma-localerc".text = ''
      [Formats]
      LANG=en_US.UTF-8
    '';

    "plasmarc".text = ''
      [Theme]
      name=WhiteSur-dark
    '';

    "kwinrc".text = ''
      [Desktops]
      Id_1=2e2dcfc2-a961-415b-838f-e6a9a1d1ffe0
      Number=1
      Rows=1

      [Tiling]
      padding=4
      tiles={"layoutDirection":"horizontal","tiles":[{"width":0.25},{"width":0.5},{"width":0.25}]}

      [Xwayland]
      Scale=1

      [org.kde.kdecoration2]
      library=org.kde.kwin.aurorae.v2
      theme=__aurorae__svg__WhiteSurLiquid-dark
    '';

    "kdeglobals".text = ''
      [Colors:Button]
      BackgroundAlternate=70,70,70
      BackgroundNormal=90,90,90
      DecorationFocus=49,91,239
      DecorationHover=49,91,239
      ForegroundActive=61,174,233
      ForegroundInactive=170,170,170
      ForegroundLink=41,128,185
    '';
  };
}
