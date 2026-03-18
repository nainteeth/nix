{
  pkgs,
  config,
  username,
  ...
}:
let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  repoDir = "/home/${username}/nix";
  configDir = "${repoDir}/home/dotfiles";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home = {
    packages = with pkgs; [
      ripgrep
      fd
      fzf
      lazygit
      gcc
      nodejs
      nil
      cargo # needed to build nil with mason
      nixfmt
      statix
      ghostscript
      nodePackages.mermaid-cli
      (python3.withPackages (ps: [ ps.pip ]))
      # Lazyvim wants this version specifically:
      lua5_1
      lua51Packages.luarocks

      tree-sitter
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    file.".config/nvim".source = mkOutOfStoreSymlink "${configDir}/nvim";
  };
}
