{
  username,
  ...
}:
{
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };
}
