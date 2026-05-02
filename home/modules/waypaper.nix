{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    awww
    waypaper
  ];
}
