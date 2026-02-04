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
    ];
}
