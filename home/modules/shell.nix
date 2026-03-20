{
  ...
}:
{
  programs = {
    lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            key = "R";
            command = "sudo nixos-rebuild switch --flake ~/nix#$(hostname)";
            context = "global";
            description = "NixOS rebuild";
            output = "terminal";
          }
          {
            key = "U";
            command = "cd $HOME/nix && sudo nix flake update";
            context = "global";
            description = "Flake update";
            output = "terminal";
          }
        ];
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      initExtra = ''
        ssh-add -l &>/dev/null || ssh-add ~/.ssh/github 2>/dev/null
      '';
      shellAliases = {
        rebuild = "git -C ~/nix add . && sudo nixos-rebuild switch --flake ~/nix#$(hostname)";
      };
    };
    # Terminal file manager
    yazi = {
      enable = false;
      enableBashIntegration = true;
    };
    # fuzzy find ctrl r (bash history)
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    # fancy ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [
        "--long"
        "--header"
      ];
    };
  };
}
