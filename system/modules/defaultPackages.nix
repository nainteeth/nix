{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    networkmanager
    networkmanagerapplet
    wget
    curl
    git
    jq
    libreoffice
    flatpak
    thunar
    thunar-volman
    thunar-archive-plugin
    libnotify
    gammastep
    xdg-utils
    kdePackages.kdeconnect-kde
    kdePackages.kio-admin
    gimp3-with-plugins
    bibata-cursors
    spotify
  ];
}
