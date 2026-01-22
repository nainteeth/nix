{ config, username, ... }:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path; # The magic line! Very good

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
    home.file.".doom.d/themes/doom-compline-theme.el" = {
      source = config.lib.file.mkOutOfStoreSymlink 
        "${config.home.homeDirectory}/nixos-config/dotfiles/compline/doom emacs/doom-compline-theme.el";
    };
    home.file.".doom.d/themes/doom-lauds-theme.el" = {
      source = config.lib.file.mkOutOfStoreSymlink 
        "${config.home.homeDirectory}/nixos-config/dotfiles/compline/doom emacs/doom-lauds-theme.el";
    };

    # Git (if I plan on adding a .gitconfig)
    # ".gitconfig".source = mkOutOfStoreSymlink "${configDir}/git/.gitconfig";

  };
}
