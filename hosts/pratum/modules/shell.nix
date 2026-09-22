{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export OSH="${config.home.homeDirectory}/.oh-my-bash"
      OSH_THEME="font"
      OMB_USE_SUDO=true
      source "''${OSH}/oh-my-bash.sh"
    '';
  };
}
