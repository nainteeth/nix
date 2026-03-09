{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf

    lazygit

    gcc
    tree-sitter

    nerd-fonts.jetbrains-mono
  ];
}
