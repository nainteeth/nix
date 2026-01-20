{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Window Manager
    hyprpaper
    hypridle
    hyprlock
    waybar
    wofi
    dunst

    # Terminal & Shell
    kitty
    starship

    # Screenshots & Media
    grim
    slurp
    wl-clipboard
    cliphist
    playerctl
    pamixer

    # Browsers
    firefox
    # Add zen-browser

    # Media
    vlc
    mpv
    spotify
    # spicetify-cli from inputs

    # Editors & IDEs
    neovim

    # Files
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    kdePackages.kio-admin
    xdg-utils

    # System utilities
    btop
    htop
    fastfetch

    # Archive tools
    unzip
    zip
    p7zip
    unrar

    # Development
    git
    gh

    # CLI tools
    ripgrep
    fd
    eza
    bat
    fzf
    tree
    wget
    curl

    # Other
    keepassxc

    # Fonts
    # THIS IS WRONG PLEASE FIX THANKS
    #(nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
  ];
}
