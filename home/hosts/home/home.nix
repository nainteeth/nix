{ inputs, hostname, username, pkgs, ... }: {
  imports = [
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/shell.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
}
