{ config, pkgs, ... }:

{
  # Starship prompt
  programs.starship = {
    enable = true; 
    enableBashIntegration = true;
    # Config is in dotfiles/starship/starship.toml (via mkOutOfStoreSymlink)
    # Could be changed since its not really necessary
  };

  programs.bash = {
    enable = true;
  };

  # Terminal file manager
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
}
