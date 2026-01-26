{ config, pkgs, username, ... }:

{
  imports = [
    ../../modules/dotfiles.nix
    ../../modules/defaultPackages.nix
    ../../modules/env-vars.nix
    ../../modules/shell.nix
    ../../modules/emacs.nix
    ../../modules/zen-browser.nix
    ../../modules/flatpak.nix
    ../../modules/git.nix
  ];

  # Desktop-specific stuff
  home.packages = with pkgs; [
    lutris
    gamemode
    mangohud
    prismlauncher
  ];

  # Emacs 2x Scale
  xresources.properties = {
    "Xft.dpi" = 192;
  };

  home.sessionVariables = {
    # Gaming optimizations that maybe work. Do some research before uncommenting these
    # __GL_SHADER_DISK_CACHE = "1";
    # __GL_THREADED_OPTIMIZATION = "1";
  };
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
