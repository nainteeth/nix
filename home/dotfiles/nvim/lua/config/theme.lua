local theme_switcher = require("config.theme_switcher")
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
  "Typedef",
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
