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
    withUWSM = false;
  };

  environment.systemPackages = with pkgs; [
    libwacom
    libinput
    wootility
  ];

  # OSU! starter pack
  hardware.opentabletdriver.enable = true;
  hardware.wooting.enable = true;
  services.udev.extraRules = ''
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0666", GROUP="input"
  '';

  # AMD GPU drivers | Do I even need to configure these? Idk
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
