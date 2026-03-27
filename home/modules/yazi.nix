{
  config,
  username,
  pkgs,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "/home/${username}/nix/home/dotfiles";
in
{
  home.packages = with pkgs; [ yazi ];

  home.file.".config/yazi".source = mkOutOfStoreSymlink "${configDir}/yazi";
}
