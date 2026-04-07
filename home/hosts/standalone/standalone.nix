# This is a standalone Home Manager config for non-NixOS systems
# You can use it with: home-manager switch --flake .#standalone
{
  username,
  ...
}:
{
  imports = [
    # DO NOT IMPORT shared.nix HERE
    ../../modules/neovim.nix
    ../../modules/devenv.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
}
