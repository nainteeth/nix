{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "nainteeth";
      user.email = "knusperpommes@gmail.com";
    };
  };
}
