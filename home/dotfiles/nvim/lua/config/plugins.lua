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
