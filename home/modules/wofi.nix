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
  home.packages = with pkgs; [ wofi ];

  home.file.".config/wofi".source = mkOutOfStoreSymlink "${configDir}/wofi";
}
