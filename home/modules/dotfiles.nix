{ config, username, ... }:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Repository location
  repoDir = "/home/${username}/NixOS-Hyprland";
  configDir = "${repoDir}/dotfiles";
in
{
  home.file = {
    # Hyprland
    ".config/hypr".source = mkOutOfStoreSymlink "${configDir}/hypr";

    # Waybar
    ".config/waybar".source = mkOutOfStoreSymlink "${configDir}/waybar";

    # Terminal
    ".config/kitty".source = mkOutOfStoreSymlink "${configDir}/kitty";

    # Vim
    ".config/nvim".source = mkOutOfStoreSymlink "${configDir}/nvim";

    # Launcher
    ".config/wofi".source = mkOutOfStoreSymlink "${configDir}/wofi";

    # Starship prompt (could be configured via home-manager instead)
    ".config/starship.toml".source = mkOutOfStoreSymlink "${configDir}/starship/starship.toml";

    # Shell
    ".bashrc".source = mkOutOfStoreSymlink "${configDir}/bash/.bashrc";

    # Git (if I plan on adding a .gitconfig)
    # ".gitconfig".source = mkOutOfStoreSymlink "${configDir}/git/.gitconfig";

    # More examples:
    # ".config/btop".source = mkOutOfStoreSymlink "${configDir}/btop";
    # ".config/fastfetch".source = mkOutOfStoreSymlink "${configDir}/fastfetch";
    # ".config/dunst".source = mkOutOfStoreSymlink "${configDir}/dunst";
    # ".config/mpv".source = mkOutOfStoreSymlink "${configDir}/mpv";
  };
}
