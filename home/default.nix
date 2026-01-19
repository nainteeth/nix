{ config, lib, pkgs, inputs, hostname, username, ... }:

{
  imports = [
    # Core modules
    ./modules/dotfiles.nix
    ./modules/packages.nix
    ./modules/session-vars.nix

    # Host-specific configuration (laptop vs desktop differences)
    ./hosts/${hostname}.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "nainteeth";
    userEmail = "your.email@example.com";  # Change this
  };

  programs.bash = {
    enable = true;
    # bashrc is managed via dotfiles symlink
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
