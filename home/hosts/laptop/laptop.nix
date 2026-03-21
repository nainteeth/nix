{
  pkgs,
  ...
}:
{
  imports = [
    ../shared.nix
  ];
  home = {
    packages = with pkgs; [
      brightnessctl
      acpi
      powertop
    ];
  };
}
