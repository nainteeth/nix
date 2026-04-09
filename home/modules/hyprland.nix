{
  pkgs,
  symlink,
  config,
  ...
}:
{

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Bilder/screenshots";
  };

  home = {
    file.".config/hypr".source = symlink config "hypr";
    packages = with pkgs; [
      hypridle
      hyprlock
      hyprpicker
      wl-clipboard # This is needed to copy the hex color from hyprpicker to clipboard
    ];
    sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };
}
