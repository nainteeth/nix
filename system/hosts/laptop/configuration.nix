{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = false;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
  services.libinput.enable = true;
}
