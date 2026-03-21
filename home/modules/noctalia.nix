{
  config,
  username,
  inputs,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "/home/${username}/nix/home/dotfiles";
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell.enable = true;

  home.file.".config/noctalia".source = mkOutOfStoreSymlink "${configDir}/noctalia";
}
