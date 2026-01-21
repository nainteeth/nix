{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # AMD GPU drivers
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
