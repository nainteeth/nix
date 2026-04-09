{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = [ pkgs.tmux ];

  home.file.".config/tmux".source = symlink config "tmux";
}
