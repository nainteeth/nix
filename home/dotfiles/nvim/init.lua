vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.timeoutlen = 0

require("catppuccin").setup({
  flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin")

---- Keybinds
vim.g.mapleader = " "
-- Dateibaum
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
-- Telescope
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>")
-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code actions" })
-- AI Chat
-- Normal Mode: Chat öffnen
-- Visual Mode: Selektion direkt an das Modell schicken
vim.keymap.set("n", "<leader>c", ":CodeCompanionChat<CR>")
vim.keymap.set("v", "<leader>c", ":CodeCompanion<CR>")

-- window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "Window close" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Window split horizontal" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window split vertical" })

---- LSP
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

-- whichkey
require("which-key").setup({
  preset = "helix",
})
require("which-key").add({
  { "<leader>w", group = "windows" },
})

-- AUTOCOMPLETE
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- AUTOFORMATTING
require("conform").setup({
  formatters_by_ft = {
    nix  = { "nixfmt" },
    json = { "prettier" },
    tex  = { "latexindent" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- NEO-TREE
require("neo-tree").setup({
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


-- Ollama läuft lokal als systemd Service auf Port 11434
require("codecompanion").setup({
  display = {
    chat = {
      window = {
        position = "right",
      },
    },
  },
  adapters = {
    ollama = require("codecompanion.adapters").extend("ollama", {
      schema = {
        model = {
          default = "qwen2.5-coder:14b",
        },
      },
      url = "http://127.0.0.1:11434",
    }),
  },
  strategies = {
    chat   = { adapter = "ollama" },
    inline = { adapter = "ollama" },
  },
})
