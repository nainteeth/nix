{ config, lib, pkgs, ... }:

{
  home.pointerCursor = {
    name = "Bibata-Modern-Classic"
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = {
      "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'"
      "gsettings set org.gnome.desktop.interface cursor-size 24"
    };
  };

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";

    targets = {
      firefox = {
        enable = true;
        profileNames = [
          "default"
        ];
      };
      wofi.enable = true;
    };
  };
}
