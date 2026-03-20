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
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig

      # Autocomplete
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      mini-nvim

      gitsigns-nvim

      # Fuzzy Finder
      telescope-nvim
      plenary-nvim

      # Dateibaum
      neo-tree-nvim
      nvim-web-devicons
      nui-nvim

      # Syntax Highlighting
      nvim-treesitter.withAllGrammars

      # Formatter
      conform-nvim

      # AI - Ollama via codecompanion
      codecompanion-nvim

      # Theme
      catppuccin-nvim
      rose-pine

      # Space menu
      which-key-nvim

      # Awesome navigation plugin
      flash-nvim

      # git stuff
      lazygit-nvim
    ];
  };

  home = {
    packages = with pkgs; [
      # Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

      # Sprachserver
      jdt-language-server # Java
      nil # Nix
      nixfmt # Nix Formatter
      texlab # LaTeX
      texlive.combined.scheme-full # LaTeX Pakete
      vscode-langservers-extracted # JSON, HTML, CSS

      # Telescope Dependencies
      ripgrep
      fd

      lazygit
    ];

    file.".config/nvim".source = mkOutOfStoreSymlink "${configDir}/nvim";
  };
}
