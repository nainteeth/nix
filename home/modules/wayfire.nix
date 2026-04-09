{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = with pkgs; [ wayfire ];

  home.file.".config/wayfire".source = symlink config "wayfire";
}
