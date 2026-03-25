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
  home.packages = with pkgs; [ mako ];

  home.file.".config/mako".source = mkOutOfStoreSymlink "${configDir}/mako";
}
