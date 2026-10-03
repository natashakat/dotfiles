{ config, pkgs, ... }:

{
  users.users."helianthus" = {
    isNormalUser = true;
    description = "helianthus maximus";
    openssh.authorizedKeys.keys = [
      # https://github.com/flakesonnix.keys
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgPFwTysg5vOZ77Zqo9AehacYvO4iTm/T4QTy7MtfD2"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAT5LcBzQCMfPyq0t29vGjz6UCcTXKZWROmUy82A0lrS"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzrW5cHMre50s8jFSbG6Yzg2TlQkKNQ59qRejIRUM0T"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSg7uG+/7pn6biGGzHTynH7FZUu0YzhfurY0L5GW7Di"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
    ];
    packages = with pkgs; [
      kdePackages.kate
      qtcreator
      nautilus
      gvfs
      prismlauncher
      heroic
      lutris
      wineWow64Packages.stable
      mangohud
      (retroarch.withCores (
        cores: with cores; [
          snes9x
          genesis-plus-gx
          mgba
          fbneo
          mupen64plus
        ]
      ))
      keepassxc
      thunderbird
      vlc
      gimp
      rawtherapee
      abcde
      strawberry
      easyeffects
      quota
      ungoogled-chromium
      freetube
      xenia-canary
      rpcs3
      ryubing
      motrix
      qbittorrent
      nicotine-plus
      opencode
      pkgs.jetbrains.clion
      pkgs.jetbrains.idea
      pkgs.jetbrains.webstorm
      pkgs.jetbrains.phpstorm
      pkgs.jetbrains.pycharm
      pkgs.jetbrains.ruby-mine
      pkgs.jetbrains.goland
      pkgs.jetbrains.datagrip
      slack
      element-desktop
      bibletime
      hyfetch
      librewolf
      
    ];
  };

  users.users."lucy" = {
    isNormalUser = true;
    description = "Lucy";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
    ];
  };

  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = builtins.listToAttrs (
        map
          ({ id, url }: {
            name = id;
            value = {
              installation_mode = "force_installed";
              install_url = url;
            };
          })
          [
            {
              id = "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}";
              url = "https://addons.mozilla.org/firefox/downloads/file/3990325/catppuccin_mocha_mauve_git-2.0.xpi";
            }
            {
              id = "{e58d3966-3d76-4cd9-8552-1582fbc800c1}";
              url = "https://addons.mozilla.org/firefox/downloads/file/4859908/buster_captcha_solver-3.4.0.xpi";
            }
            {
              id = "uBlock0@raymondhill.net";
              url = "https://addons.mozilla.org/firefox/downloads/file/5034826/ublock_origin-1.75.0.xpi";
            }
            {
              id = "sponsorBlocker@ajay.app";
              url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock-6.1.7.xpi";
            }
            {
              id = "tab-counter@daawesomep.addons.mozilla.org";
              url = "https://addons.mozilla.org/firefox/downloads/file/4272096/tab_counter_webext-0.4.2resigned1.xpi";
            }
            {
              id = "adguardadblocker@adguard.com";
              url = "https://addons.mozilla.org/firefox/downloads/file/4986231/adguard_adblocker-5.5.2.3.xpi";
            }
            {
              id = "jid1-q4sG8pYhq8KGHs@jetpack";
              url = "https://addons.mozilla.org/firefox/downloads/file/4780259/adblock_for_youtube-0.5.4.xpi";
            }
            {
              id = "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}";
              url = "https://addons.mozilla.org/firefox/downloads/file/5014115/video_downloadhelper-10.5.49.2.xpi";
            }
            {
              id = "keepassxc-browser@keepassxc.org";
              url = "https://addons.mozilla.org/firefox/downloads/file/4831838/keepassxc_browser-1.10.3.xpi";
            }
            {
              id = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
              url = "https://addons.mozilla.org/firefox/downloads/file/5037282/bitwarden_password_manager-2026.9.0.xpi";
            }
          ]
      );
    };
  };
}
