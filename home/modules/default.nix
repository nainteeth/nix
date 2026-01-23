{ config, lib, pkgs, inputs, hostname, username, ... }:

{
  # Nested imports!
  imports = [
    # Core modules
    ./dotfiles.nix
    ./packages.nix
    ./env-vars.nix
    ./shell.nix
    ./emacs.nix
    ./zen-browser.nix

    # Host-specific configuration
    ../hosts/${hostname}.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "nainteeth";
      user.email = "knusperpommes@gmail.com";
    };
  };
}
