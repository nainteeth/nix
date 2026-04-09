{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = with pkgs; [ mako ];

  home.file.".config/mako".source = symlink config "mako";
}
