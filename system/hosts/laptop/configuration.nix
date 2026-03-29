{
  pkgs,
  username,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
}
