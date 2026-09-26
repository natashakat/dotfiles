{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "helianthus";
  home.homeDirectory = "/home/helianthus";
  home.stateVersion = "26.05";
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

  programs.git = {
    enable = true;
    settings = {
      user.name = "helianthus";
      user.email = "helianthus@pratum";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "hx";
      alias = {
        st = "status -sb";
        co = "checkout";
        br = "branch";
        lg = "log --oneline --graph -15";
      };
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";
        indent-guides.render = true;
        soft-wrap.enable = true;
        file-picker.hidden = false;
        lsp.display-messages = true;
      };
    };
    languages = {
      language-server.rust-analyzer.command = "rust-analyzer";
      language-server.nil.command = "nil";
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = { command = "nixfmt"; };
        }
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber
      set expandtab shiftwidth=2 tabstop=2
      set termguicolors
      set mouse=a
    '';
  };

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
        mhutchie.git-graph
        usernamehw.errorlens
        catppuccin.catppuccin-vsc
        pkief.material-icon-theme
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "qt-qml";
            publisher = "TheQtCompany";
            version = "1.17.0";
            sha256 = "sha256-4P0v3r1pHgLKR7Jt3Je3kBHSwVZ2djWlxQOmAbTsM/0=";
          };
        })
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "qt-core";
            publisher = "TheQtCompany";
            version = "1.17.0";
            sha256 = "sha256-knBG17lcrr3NP5sxMtbgG6coiEM//caEeei2NWKfJVk=";
          };
        })
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
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      tree = "eza --tree";
      cat = "bat";
      grep = "rg";
      find = "fd";
      rb = "nixos-rebuild switch --flake ~/Documents/dotfiles --use-remote-sudo";
      rbtest = "nixos-rebuild test --flake ~/Documents/dotfiles --use-remote-sudo";
    };
    initExtra = ''
      eval "$(starship init bash)"
      export LS_COLORS="$(vivid generate catppuccin-mocha)"
    '';
    sessionVariables = {
      FZF_DEFAULT_OPTS = "--color=bg:#1e1e2e,fg:#cdd6f4,hl:#f5c2e7,fg+:#cdd6f4,bg+:#45475a,hl+:#f5c2e7,info:#cba6f7,prompt:#cba6f7,pointer:#f5c2e7,marker:#f5c2e7,spinner:#f5c2e7,header:#f5c2e7";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$nix_shell$character";
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
      directory = {
        style = "blue";
        truncation_length = 3;
      };
      git_branch = {
        style = "mauve";
      };
      nix_shell = {
        symbol = "❄️ ";
      };
      character = {
        success_symbol = "[➜](green)";
        error_symbol = "[➜](red)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.eza = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g status-style 'bg=#1e1e2e,fg=#cdd6f4'
      set -g status-left '#[fg=#cba6f7,bold] #S '
      set -g status-right '#[fg=#94e2d5]%H:%M #[fg=#6c7086]| #[fg=#cdd6f4]%d-%m '
      set -g window-status-current-style 'fg=#1e1e2e,bg=#cba6f7,bold'
      set -g window-status-style 'fg=#a6adc8'
      set -g pane-border-style 'fg=#45475a'
      set -g pane-active-border-style 'fg=#cba6f7'
      set -g message-style 'bg=#313244,fg=#cdd6f4'
      set -g mode-style 'bg=#45475a,fg=#cdd6f4'
    '';
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
    themes = {
      catppuccin = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/zellij/main/catppuccin.kdl";
        sha256 = "sha256-Np7k/lsmue437aPZh6RZcOt03haLedJlOCaZ8+4nCoo=";
      };
    };
  };

  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "logo": {
        "type": "auto"
      },
      "display": {
        "separator": " ➜ ",
        "color": {
          "keys": "#cba6f7",
          "title": "#f5c2e7",
          "separator": "#6c7086"
        }
      },
      "modules": [
        "os",
        "host",
        "kernel",
        "uptime",
        "packages",
        "shell",
        "de",
        "wm",
        "terminal",
        "cpu",
        "memory",
        "disk",
        "battery",
        "break",
        "colors"
      ]
    }
  '';

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

  # KDE Plasma, declaratively managed via plasma-manager.
  # NOTE: plasma-manager owns plasmarc/kwinrc/kdeglobals/kcminputrc, so those
  # must NOT also be set via xdg.configFile (would conflict).
  programs.plasma = {
    enable = true;
    workspace = {
      theme = "breeze-dark";
      lookAndFeel = "Catppuccin-Mocha-Mauve";
      colorScheme = "CatppuccinMochaMauve";
      iconTheme = "Papirus-Dark";
      cursor = {
        theme = "catppuccin-mocha-mauve-cursors";
        size = 24;
      };
      wallpaper = "${../../../assets/wallpaper.webp}";
    };
    kscreenlocker.appearance.wallpaper = "${../../../assets/wallpaper.webp}";
    fonts = {
      general = {
        family = "Noto Sans";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };
    kwin = {
      virtualDesktops = {
        number = 1;
        rows = 1;
      };
      nightLight = {
        enable = true;
        mode = "location";
        location = {
          latitude = "52.37";
          longitude = "4.91";
        };
      };
      tiling = {
        padding = 4;
        layout = {
          id = "2e2dcfc2-a961-415b-838f-e6a9a1d1ffe0";
          tiles = {
            layoutDirection = "horizontal";
            tiles = [
              { width = 0.25; }
              { width = 0.5; }
              { width = 0.25; }
            ];
          };
        };
      };
    };
    shortcuts = {
      kmix = {
        decrease_volume = "Volume Down";
        increase_volume = "Volume Up";
        mute = "Volume Mute";
      };
      kwin = {
        "Show Desktop" = "Meta+D";
      };
    };
    kwin.effects = {
      blur.enable = true;
      translucency.enable = true;
    };
  };

  xdg.configFile = {
    "plasma-localerc".text = ''
      [Formats]
      LANG=en_US.UTF-8
    '';

    "kate/katerc".text = ''
    '';

    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=true
      gtk-button-images=true
      gtk-cursor-blink=true
      gtk-cursor-blink-time=1000
      gtk-cursor-theme-name=catppuccin-mocha-mauve-cursors
      gtk-cursor-theme-size=24
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-font-name=Noto Sans, 10
      gtk-icon-theme-name=Papirus-Dark
      gtk-menu-images=true
      gtk-modules=colorreload-gtk-module
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-theme-name=catppuccin-mocha-mauve-standard
      gtk-toolbar-style=3
      gtk-xft-dpi=98304
    '';

    "gtkrc-2.0".text = ''
      gtk-enable-animations=1
      gtk-theme-name="catppuccin-mocha-mauve-standard"
      gtk-primary-button-warps-slider=1
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-blink-time=1000
      gtk-cursor-blink=1
      gtk-cursor-theme-size=24
      gtk-cursor-theme-name="catppuccin-mocha-mauve-cursors"
      gtk-sound-theme-name=ocean
      gtk-icon-theme-name=Papirus-Dark
      gtk-font-name=Noto Sans,  10
    '';

    "mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/freetube=freetube.desktop
      x-scheme-handler/mo=motrix.desktop
      x-scheme-handler/motrix=motrix.desktop
      x-scheme-handler/magnet=motrix.desktop
    '';

    "konsolerc".text = ''
      [Desktop Entry]
      DefaultProfile=Catppuccin-Mocha.profile
    '';

    "vesktop/themes/catppuccin-mocha-mauve.theme.css".source = pkgs.fetchurl {
      url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css";
      sha256 = "sha256-kX6O2wxQpZvCF2RjsP4yH+Ojvijd8KJ/uCVu/VObTOg=";
    };

    "btop/themes/catppuccin_mocha.theme".source = pkgs.fetchurl {
      url = "https://github.com/catppuccin/btop/raw/main/themes/catppuccin_mocha.theme";
      sha256 = "sha256-THRpq5vaKCwf9gaso3ycC4TNDLZtBB5Ofh/tOXkfRkQ=";
    };

    "konsole/Catppuccin-Mocha.profile".text = ''
      [General]
      Name=Catppuccin-Mocha
      Parent=FALLBACK/

      [Appearance]
      ColorScheme=Catppuccin-Mocha
      Font=JetBrains Mono,12,-1,5,50,0,0,0,0,0
    '';

    "konsole/Catppuccin-Mocha.colorscheme".text = ''
      [Background]
      Color=30,30,46

      [BackgroundIntense]
      Color=49,50,68

      [Color0]
      Color=69,71,90

      [Color0Intense]
      Color=88,91,112

      [Color1]
      Color=243,139,168

      [Color1Intense]
      Color=243,139,168

      [Color2]
      Color=166,227,161

      [Color2Intense]
      Color=166,227,161

      [Color3]
      Color=249,226,175

      [Color3Intense]
      Color=249,226,175

      [Color4]
      Color=137,180,250

      [Color4Intense]
      Color=137,180,250

      [Color5]
      Color=245,194,231

      [Color5Intense]
      Color=245,194,231

      [Color6]
      Color=148,226,213

      [Color6Intense]
      Color=148,226,213

      [Color7]
      Color=186,194,222

      [Color7Intense]
      Color=166,173,200

      [Foreground]
      Color=205,214,244

      [ForegroundIntense]
      Color=205,214,244

      [General]
      Description=Catppuccin Mocha
      Opacity=1
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
