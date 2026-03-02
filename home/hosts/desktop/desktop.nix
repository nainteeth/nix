{
  pkgs,
  username,
  ...
}:

{
  imports = [
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
  ];

  # Desktop-specific stuff
  home = {
    packages = with pkgs; [
      lutris
      gamemode
      mangohud
      prismlauncher
    ];
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

}
