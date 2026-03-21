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
  home.packages = with pkgs; [ waybar ];

  home.file.".config/waybar".source = mkOutOfStoreSymlink "${configDir}/waybar";
}
