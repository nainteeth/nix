{ config, lib, pkgs, inputs, hostname, username, ... }:

{
  imports = [
    # Core modules
    ./modules/dotfiles.nix
    ./modules/packages.nix
    ./modules/session-vars.nix

    # Host-specific configuration
    ./hosts/${hostname}.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "nainteeth";
    userEmail = "knusperpommes@gmail.com";
  };

  programs.bash = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
