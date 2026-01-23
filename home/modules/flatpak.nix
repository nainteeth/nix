{ inputs, pkgs, nix-flatpak, ... }:

{
  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false; # Only manages user packages

    packages = [
      "com.discordapp.Discord"
      "sh.ppy.osu"
      "com.bambulab.BambuStudio"
    ];

    overrides = {
      "com.discordapp.Discord" = {
        Context.filesystems = [
          "xdg-run/pipewire-0"
        ];
        Environment.XDG_SESSION_TYPE = "wayland";
        Context.sockets = [
          "wayland"
          "x11"
          "pulseaudio"
        ];
        "Session Bus Policy" = {
          "org.freedesktop.portal.Desktop" = "talk";
        };
      };
    };
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };
}
