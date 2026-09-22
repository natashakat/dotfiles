{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "helianthus";
  home.homeDirectory = "/home/helianthus";
  home.stateVersion = "26.05";
  # HM 26.05 vs nixpkgs 26.11 release mismatch warning suppressed
  home.enableNixpkgsReleaseCheck = false;

  programs.obsidian = {
    enable = true;
    defaultSettings.app = "vscodium-fhs";
    package = pkgs.obsidian;
    vaults = {
      main = {
        enable = true;
        target = "Documents/dotfiles/vault";
      };
    };
  };

  programs.git.enable = true;
  programs.git.settings.user.name = "helianthus";
  programs.git.settings.user.email = "helianthus@pratum";

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium-fhs;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
        ms-python.python
        editorconfig.editorconfig
        esbenp.prettier-vscode
        eamodio.gitlens
        usernamehw.errorlens
        catppuccin.catppuccin-vsc
        pkief.material-icon-theme
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "workbench.smoothScrolling" = true;
        "workbench.list.smoothScrolling" = true;
        "editor.fontFamily" = "JetBrains Mono";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.minimap.enabled" = false;
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = true;
        "editor.stickyScroll.enabled" = true;
        "editor.formatOnSave" = true;
        "files.autoSave" = "afterDelay";
        "terminal.integrated.fontFamily" = "JetBrains Mono";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixfmt";
        "rust-analyzer.check.command" = "clippy";
      };
    };
  };
  programs.bash.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "\${HOME}/Desktop";
    download = "\${HOME}/Downloads";
    templates = "\${HOME}/Templates";
    publicShare = "\${HOME}/Public";
    documents = "\${HOME}/Documents";
    music = "\${HOME}/Music";
    pictures = "\${HOME}/Pictures";
    videos = "\${HOME}/Videos";
  };

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

    "kate/katerc".text = ''
    '';

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

    "mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/freetube=freetube.desktop
      x-scheme-handler/mo=motrix.desktop
      x-scheme-handler/motrix=motrix.desktop
      x-scheme-handler/magnet=motrix.desktop
    '';
  };

  programs.thunderbird.enable = true;
  programs.freetube.enable = true;
  programs.keepassxc.enable = true;
  programs.prismlauncher.enable = true;

  home.packages = with pkgs; [
    obsidian
  ];
}
