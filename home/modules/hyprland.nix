{
  config,
  username,
  pkgs,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "/home/${username}/nix/home/dotfiles";
in
{

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Bilder/screenshots";
  };

  home = {
    file.".config/hypr".source = mkOutOfStoreSymlink "${configDir}/hypr";
    packages = with pkgs; [
      hypridle
      hyprlock
      hyprpicker
    ];
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };
}
