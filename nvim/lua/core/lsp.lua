vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

vim.lsp.config("qmlls", {
    cmd = { "qmlls6" },
    filetypes = { 'qml', 'qmljs' },
    root_markers = { 'main.cpp' },
})
vim.lsp.config("lua_ls",  {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("qmlls")
