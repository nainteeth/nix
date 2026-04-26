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
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

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

    extraLuaConfig = ''
      do
        -- options.lua
        vim.g.mapleader = " "

        vim.o.number = true
        vim.o.relativenumber = true
        vim.o.scrolloff = 8
        vim.o.tabstop = 2
        vim.o.shiftwidth = 2
        vim.o.expandtab = true
        vim.o.signcolumn = "yes"
        vim.o.termguicolors = true
        vim.o.timeoutlen = 0
        vim.o.clipboard = "unnamedplus"
        vim.o.fillchars = "eob: "
      end

      do
        -- keymaps.lua
        local map = vim.keymap.set

        -- Dateibaum
        map("n", "<leader>e", ":Neotree toggle<CR>")

        -- Telescope
        map("n", "<leader>f", ":Telescope find_files<CR>")
        map("n", "<leader>/", ":Telescope live_grep<CR>")
        map("n", "<leader>b", ":Telescope buffers<CR>")

        -- LSP
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
        map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code actions" })

        -- window navigation
        map("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
        map("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
        map("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
        map("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
        map("n", "<leader>wd", "<C-w>q", { desc = "Window close" })
        map("n", "<leader>ws", "<C-w>s", { desc = "Window split horizontal" })
        map("n", "<leader>wv", "<C-w>v", { desc = "Window split vertical" })

        -- wichtigste Keybinds überhaupt
        map("n", "<leader>ör", ":CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
        map("n", "<leader>ög", ":CellularAutomaton game_of_life<CR>", { desc = "Game of life" })

        -- Auswahl beibehalten nach indent
        map("v", "<", "<gv")
        map("v", ">", ">gv")
      end

      do
        -- lsp.lua
        -- Nix
        vim.lsp.config("nil_ls", {
          settings = {
            ["nil"] = {
              formatting = { command = { "nixfmt" } },
            },
          },
        })

        -- Java
        vim.lsp.config("jdtls", {
          cmd = { "jdtls" },
          root_markers = { ".git", "pom.xml", "build.gradle" },
        })

        -- LaTeX
        vim.lsp.config("texlab", {
          settings = {
            texlab = {
              build = {
                onSave = true,
              },
            },
          },
        })

        -- JSON
        vim.lsp.config("jsonls", {})

        -- Alle Server aktivieren
        vim.lsp.enable({ "nil_ls", "jdtls", "texlab", "jsonls" })
      end

      local theme_switcher = {}
      do
        -- theme_switcher.lua
        local theme_file = vim.fn.expand("~/.config/nvim/current_theme.txt")

        local function set_transparent()
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
        end

        function theme_switcher.get_theme()
          local f = io.open(theme_file, "r")
          if f then
            local theme = f:read("*l")
            f:close()
            return theme
          end
          return "everforest"
        end

        function theme_switcher.reload()
          local theme = theme_switcher.get_theme()
          vim.cmd.colorscheme(theme)
          set_transparent()
          require("lualine").setup({ options = { theme = theme } })
        end
        
        _G.theme_switcher = theme_switcher
      end

      do
        -- theme.lua
        local current_theme = theme_switcher.get_theme()

        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = true,
        })
        require("rose-pine").setup({
          variant = "main",
          dark_variant = "main",
          dim_inactive_windows = false,
          extend_background_behind_borders = true,
        })
        require("lackluster").setup({})
        require("tokyonight").setup({ transparent = true })
        require("kanagawa").setup({ transparent = true })
        require("onedark").setup({ style = "dark", transparent = true })

        vim.cmd.colorscheme(current_theme)

        local bold_groups = {
          "Keyword", "Statement", "Condition", "Repeat", "Exception",
          "Label", "Operator", "Function", "Type", "StorageClass",
          "Structure", "Typedef"
        }

        for _, group in ipairs(bold_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
          hl.bold = true
          vim.api.nvim_set_hl(0, group, hl)
        end

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

        require("lualine").setup({
          options = {
            theme = current_theme,
          },
        })
      end

      do
        -- plugins.lua
        local map = vim.keymap.set

        -- which-key
        require("which-key").setup({
          preset = "helix",
        })
        require("which-key").add({
          { "<leader>w", group = "Windows" },
          { "<leader>g", group = "Git" },
          { "<leader>ö", group = "Das Leben" },
        })
        require("which-key").add({
          { "gc", desc = "Comment", mode = { "n", "v" } },
          { "gcc", desc = "Comment line" },
        })

        -- hexfarben
        require("colorizer").setup()

        -- flash.nvim
        local flash = require("flash")
        flash.setup({})
        map({ "n", "x", "o" }, "s", function()
          flash.jump()
        end, { desc = "Flash seek" })
        map({ "n", "x", "o" }, "S", function()
          flash.treesitter()
        end, { desc = "Flash treesitter" })

        -- mini.nvim
        require("mini.comment").setup()

        -- Markdown previews
        require("render-markdown").setup()

        -- autopairs
        require("nvim-autopairs").setup()
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        -- lazygit
        map("n", "<leader>gg", function()
          local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
          require("lazygit").lazygit(root)
        end, { desc = "LazyGit" })
        require("which-key").add({
          { "<leader>gg", desc = "LazyGit" },
        })

        -- gitsigns
        require("gitsigns").setup({})

        -- autocomplete
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
        })

        -- AUTOFORMATTING
        require("conform").setup({
          formatters_by_ft = {
            nix = { "nixfmt" },
            json = { "prettier" },
            tex = { "latexindent" },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
          },
        })

        -- NEO-TREE
        require("neo-tree").setup({
          close_if_last_window = true,
          window = {
            width = 30,
            mappings = {
              ["<space>"] = false,
            },
          },
          filesystem = {
            follow_current_file = {
              enabled = true,
            },
            hide_dotfiles = false,
          },
        })
      end
    '';
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
}
