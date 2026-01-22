{ config, pkgs, ... }:

{
  # Starship prompt
  programs.starship = {
    enable = true; 
    enableBashIntegration = true;
    # Config is in dotfiles/starship/starship.toml (via mkOutOfStoreSymlink)
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      ssh-add -l &>/dev/null || ssh-add ~/.ssh/github 2>/dev/null
    '';
  };

  # Terminal file manager
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
}
