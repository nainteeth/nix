{ config, pkgs, ... }:

{
  # Laptop-specific stuff
  home.packages = with pkgs; [
    # Power management
    brightnessctl
    acpi
    powertop
  ];

  home.sessionVariables = {
    # Could be useful in the future
  };
}
