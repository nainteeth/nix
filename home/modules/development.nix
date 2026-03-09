{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Language runtimes
    go
    cargo
    ruby
    php
    php.packages.composer
    jdk
    julia
    python3
    python3Packages.pip

    # Compilers / build tools
    clang

    # Formatters & linters
    nixfmt
    nodePackages.prettier

    # Libraries
    glib
    sqlite
  ];
}
