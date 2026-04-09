{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = with pkgs; [ yazi ];

  home.file.".config/yazi".source = symlink config "yazi";
}
