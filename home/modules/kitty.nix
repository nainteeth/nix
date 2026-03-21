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
  home.packages = with pkgs; [ kitty ];

  home.file.".config/kitty".source = mkOutOfStoreSymlink "${configDir}/kitty";
}
