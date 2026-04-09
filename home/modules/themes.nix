{
  symlink,
  config,
  ...
}:
{
  home.file.".config/themes".source = symlink config "themes";
}
