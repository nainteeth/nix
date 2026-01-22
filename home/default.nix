{ config, lib, pkgs, inputs, hostname, username, ... }:

{
  imports = [
    # Core modules
    ./modules/dotfiles.nix
    ./modules/packages.nix
    ./modules/env-vars.nix
    ./modules/shell.nix
    ./modules/emacs.nix
    ./modules/zen-browser.nix

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
    settings = {
      user.name = "nainteeth";
      user.email = "knusperpommes@gmail.com";
    };
  };
}
