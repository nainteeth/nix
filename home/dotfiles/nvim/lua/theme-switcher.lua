local M = {}

local theme_file = vim.fn.expand("~/.config/nvim/current_theme.txt")

local function set_transparent()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
end

function M.get_theme()
    local f = io.open(theme_file, "r")
    if f then
        local theme = f:read("*l")
        f:close()
        return theme
    end
    return "everforest"
end

function M.reload()
    local theme = M.get_theme()
    vim.cmd.colorscheme(theme)
    set_transparent()
    require("lualine").setup({ options = { theme = theme } })
end

return M
