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

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
    nerd-fonts.ubuntu-mono
  ];
}
