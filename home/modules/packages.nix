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
    thunar

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

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
  ];
}
