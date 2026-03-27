{
  config,
  username,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "/home/${username}/nix/home/dotfiles";
in
{
  home.file.".config/themes".source = mkOutOfStoreSymlink "${configDir}/themes";
}
