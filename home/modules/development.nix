{ config, pkgs, inputs, ... }:
{
    home.packages = with pkgs; [
        lua
        luarocks
        go
        cargo
        ruby
        php
        php.packages.composer
        jdk
        julia
        python3
        tree-sitter
        clang
        lazygit
        glib
        ghostscript # gs command for neovim (snacks.nvim)
        nodePackages.mermaid-cli # (snacks.nvim)
        sqlite
        python3Packages.pip
        nixfmt
        nodePackages.prettier
    ];
}
