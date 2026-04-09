local theme_switcher = require("theme-switcher")
local currentTheme = theme_switcher.get_theme()

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

-- window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "Window close" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Window split horizontal" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window split vertical" })

-- wichtigste Keybinds überhaupt
vim.keymap.set("n", "<leader>ör", ":CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
vim.keymap.set("n", "<leader>ög", ":CellularAutomaton game_of_life<CR>", { desc = "Game of life" })

-- auswahl beibehalten nach indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

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

-- Themes:
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

vim.cmd.colorscheme(currentTheme)
-- Bold Text ist gut
local bold_groups = {
    "Keyword",
    "Statement",
    "Condition",
    "Repeat",
    "Exception",
    "Label",
    "Operator",
    "Function",
    "Type",
    "StorageClass",
    "Structure",
    "Typedef"
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
    theme = currentTheme,
  },
})


-- whichkey
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
require("flash").setup({})
vim.keymap.set({"n", "x", "o"}, "s", function() require("flash").jump() end, { desc = "Flash seek" })
vim.keymap.set({"n", "x", "o"}, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })

-- mini.nvim
require("mini.comment").setup()

-- Mardown previews
require("render-markdown").setup()

-- autopairs
require("nvim-autopairs").setup()
-- für auto indent in einer Klammer:
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
  local root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel")[1]
  require("lazygit").lazygit(root)
end, { desc = "LazyGit" })
require("which-key").add({
  { "<leader>gg", desc = "LazyGit" },
})

-- gitsigns
require("gitsigns").setup({})

-- autocomplete
local cmp = require("cmp")
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
