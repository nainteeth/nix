{ config, pkgs, ... }:

{
  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Shell aliases - Maybe I will just use the makefile instead
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/NixOS-Hyprland#$(hostname)";
      update = "cd ~/NixOS-Hyprland && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    # Config is in dotfiles/starship/starship.toml (via mkOutOfStoreSymlink)
    # Could be changed since its not really necessary
  };

  # Terminal file manager
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
}
