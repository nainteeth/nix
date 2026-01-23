{ config, pkgs, ... }:

{
  imports = [
    ../../modules/default.nix
  ];

  # Desktop-specific stuff
  home.packages = with pkgs; [
    steam
    lutris
    gamemode
    mangohud
  ];

  home.sessionVariables = {
    # Gaming optimizations that maybe work. Do some research before uncommenting these
    # __GL_SHADER_DISK_CACHE = "1";
    # __GL_THREADED_OPTIMIZATION = "1";
  };
}
