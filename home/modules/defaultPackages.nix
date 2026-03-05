{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Basic WM stuff
    # hyprpaper
    hypridle
    hyprlock
    # waybar
    # wofi
    # swww
    # swaynotificationcenter

    # Terminal stuff
    kitty
    starship

    # Media
    playerctl
    pamixer
    pavucontrol
    uxplay
    vlc
    mpv

    # Browsers
    firefox
    chromium

    # Text Editor
    jetbrains.idea

    # System utilities
    btop
    htop
    fastfetch
    xrdb

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
    # waypaper
    hyprpicker
    signal-desktop

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
    nerd-fonts.ubuntu-mono
  ];
  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Bilder/screenshots";
  };
}
