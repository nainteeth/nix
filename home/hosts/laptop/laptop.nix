{ config, username, pkgs, ... }:

{
  imports = [
    ../../modules/dotfiles.nix
    ../../modules/packages.nix
    ../../modules/env-vars.nix
    ../../modules/shell.nix
    ../../modules/emacs.nix
    ../../modules/zen-browser.nix
    ../../modules/flatpak.nix
    ../../modules/git.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    acpi
    powertop
  ];

  home.sessionVariables = {
    # Could be useful in the future
  };

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
