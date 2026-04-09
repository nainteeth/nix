{
  symlink,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell.enable = true;

  home.file.".config/noctalia".source = symlink config "noctalia";
}
