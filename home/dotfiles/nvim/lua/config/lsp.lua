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
