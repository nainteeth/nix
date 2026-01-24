{ config, username, hostname, ... }:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Repository location
  repoDir = "/home/${username}/nix";
  configDir = "${repoDir}/home/dotfiles";
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

    # Emacs
    ".config/doom".source = mkOutOfStoreSymlink "${configDir}/doom";

    # SwayNC (Notifications)
    ".config/swaync".source = mkOutOfStoreSymlink "${configDir}/swaync";

  };
}
