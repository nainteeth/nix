{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = with pkgs; [ waybar ];

  home.file.".config/waybar".source = symlink config "waybar";
}
