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

-- auswahl beibehalten nach indent
map("v", "<", "<gv")
map("v", ">", ">gv")
