{
  pkgs,
  nix-flatpak,
  ...
}:
{
  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
    ../shared.nix
  ];
  home = {
    packages = with pkgs; [
      lutris
      gamemode
      mangohud
      prismlauncher
    ];
  };
  services.flatpak.packages = [
    "sh.ppy.osu"
  ];
}
