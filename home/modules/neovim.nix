{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig

      # Autocomplete
      nvim-cmp # popup menu
      cmp-nvim-lsp # Vorschlaege vom lsp (zB. Variablennamen)
      cmp-buffer # Vorschlaege basierend auf bereits geschriebenen Worten
      cmp-path # Dateipfadvorschlaege

      # for Keybind: gcc
      mini-nvim

      # () [] {} `` ""
      nvim-autopairs

      # fancy Symbole für veränderte Dinge im git repo
      gitsigns-nvim

      # Fuzzy Finder
      telescope-nvim
      plenary-nvim

      # file tree
      neo-tree-nvim
      nvim-web-devicons
      nui-nvim

      # Syntax Highlighting
      nvim-treesitter.withAllGrammars

      # Formatter
      conform-nvim

      # Theme
      catppuccin-nvim
      rose-pine
      gruvbox-nvim
      everforest
      lackluster-nvim
      tokyonight-nvim
      nord-nvim
      dracula-nvim
      kanagawa-nvim
      onedark-nvim
      nightfox-nvim
      oxocarbon-nvim

      # hexfarben
      nvim-colorizer-lua

      # fancy bar at the bottom
      lualine-nvim

      # Space menu
      which-key-nvim

      # Awesome navigation plugin
      flash-nvim

      # git stuff
      lazygit-nvim

      # Previews
      render-markdown-nvim

      # LIFE
      cellular-automaton-nvim
    ];
  };

  home = {
    packages = with pkgs; [
      # Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

      lazygit

      # Sprachserver
      jdt-language-server # Java
      nil # Nix
      nixfmt # Nix Formatter
      texlab # LaTeX
      texlive.combined.scheme-medium # LaTeX Pakete
      vscode-langservers-extracted # JSON, HTML, CSS

      # Telescope Dependencies
      ripgrep
      fd
    ];
  };

  xdg.configFile."nvim" = {
    source = ../dotfiles/nvim;
    recursive = true;
  };
}
