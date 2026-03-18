{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # Language runtimes
    go
    ruby
    php
    php.packages.composer
    jdk
    julia

    # Formatters & linters
    nodePackages.prettier

    # Libraries
    glib
    sqlite
  ];
}
