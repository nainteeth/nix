{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/defaultHome.nix
    ../../modules/dotfiles.nix
    ../../modules/defaultPackages.nix
    ../../modules/env-vars.nix
    ../../modules/shell.nix
    ../../modules/emacs.nix
    ../../modules/zen-browser.nix
    ../../modules/flatpak.nix
    ../../modules/git.nix
    ../../modules/development.nix
    ../../modules/noctalia.nix
    ../../modules/neovim.nix
  ];
  home = {
    packages = with pkgs; [
      brightnessctl
      acpi
      powertop
    ];
  };
}
