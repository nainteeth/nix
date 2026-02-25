{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = ~/Bilder/Wallpaper/monochrome-mountains.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

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

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'"
      "gsettings set org.gnome.desktop.interface cursor-size 24"
      "xfconf-query -c xsettings -p /Net/IconThemeName -s 'Papirus-Dark' --create -t string"
    ];
  };
}
