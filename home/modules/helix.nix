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
  programs.helix = {
    enable = true;
    defaultEditor = false;
  };
  home = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

      # Java
      jdt-language-server

      # Nix
      nil
      nixfmt

      # LaTeX
      texlab
      zathura
      texlive.combined.scheme-full
      ltex-ls

      # Für json
      vscode-langservers-extracted

      markdown-oxide
    ];

    file.".config/helix".source = mkOutOfStoreSymlink "${configDir}/helix";
  };
}
