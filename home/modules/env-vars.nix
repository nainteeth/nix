{ config, ... }:

{
  # Session variables for Wayland/Hyprland
  home.sessionVariables = {
    # Wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GDK_SCALE = "2";

    # Hyprland
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # Editor
    EDITOR = "emacs";
    VISUAL = "emacs";
  };

  xresources.properties = {
    "Xft.dpi" = 192;
  };
}
