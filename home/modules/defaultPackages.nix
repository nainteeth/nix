{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Window Manager
    hyprpaper
    hypridle
    hyprlock
    waybar
    wofi
    swww
    swaynotificationcenter

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
    pavucontrol

    # Browsers
    firefox
    chromium

    # Media
    vlc
    mpv

    # Editors & IDEs
    neovim

    # System utilities
    btop
    htop
    fastfetch
    xorg.xrdb

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
    waypaper
    hyprpicker

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
    nerd-fonts.ubuntu-mono
  ];
}
