{
  pkgs,
  symlink,
  config,
  ...
}:
{
  home.packages = with pkgs; [ wofi ];

  home.file.".config/wofi".source = symlink config "wofi";
}
