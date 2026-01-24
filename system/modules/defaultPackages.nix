{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    networkmanager
    networkmanagerapplet
    wget
    curl
    git
    jq
    libreoffice
    flatpak
    thunar
    thunar-volman
    thunar-archive-plugin
    libnotify
    gammastep
    xdg-utils
    kdePackages.kdeconnect-kde
    kdePackages.kio-admin
    gimp3-with-plugins
    bibata-cursors
    spotify
    # These fixes dont quite work yet. Use ctrl - while in spotify to scale down.
    (pkgs.symlinkJoin {
      name = "spotify";
      paths = [ pkgs.spotify ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --set GDK_SCALE 1 \
          --set GDK_DPI_SCALE 1 \
          --add-flags "--disable-gpu" \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland" \
          --add-flags "--force-device-scale-factor=1"
      '';
    })
  ];
}
