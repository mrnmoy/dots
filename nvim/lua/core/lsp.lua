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

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local mode = vim.api.nvim_get_mode().mode
        local filetype = vim.bo.filetype
        if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" then
            vim.cmd('lua vim.lsp.buf.format()')
        else
        end
    end
})

vim.lsp.config("vimls",  {
    cmd = { 'vim-language-server', '--stdio' },
    filetypes = { 'vim' },
})
vim.lsp.config("lua_ls",  {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', 'stylua.toml', '.stylua.toml' },
})
vim.lsp.config("cmake",  {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', 'build', 'cmake' },
    init_options = {
        buildDirectory = 'build',
    },
})
vim.lsp.config("clangd",  {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'h', 'hpp', 'objc', 'objcpp', 'cuda' },
    root_markers = { '.clangd' },
})
vim.lsp.config("bashls",  {
    cmd = { 'bash-language-server' },
    filetypes = { 'sh', 'bash' },
})
vim.lsp.config("hyprls",  {
    cmd = { 'hyprls', '--stdio' },
    filetypes = { 'hyprlang' },
})
vim.lsp.config("marksman", {
    cmd = { "marksman", 'server' },
    filetypes = { 'markdown', 'markdown.mdx' },
    root_markers = { '.marksman.toml' },
})
vim.lsp.config("html", {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { 'package.json' },
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { 'html', 'css', 'javascript' },
    },
})
vim.lsp.config("cssls", {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json' },
    init_options = { provideFormatter = true },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
})
vim.lsp.config("ts_ls", {
    init_options = { hostInfo = 'neovim' },
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
})
vim.lsp.config("qmlls", {
    cmd = { "qmlls6" },
    filetypes = { 'qml', 'qmljs' },
    root_markers = { 'main.cpp' },
})
vim.lsp.config("kotlin-lsp", {
    cmd = { "kotlin-lsp", '--stdio' },
    filetypes = { 'kotlin' },
    root_markers = { 
        'settings.gradle',
        'settings.gradle.kts',
        'build.gradle', 
        'build.gradle.kts'
    },
})
vim.lsp.config("tailwindcss", {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = { 
        -- html
        'aspnetcorerazor',
        'astro',
        'astro-markdown',
        'blade',
        'clojure',
        'django-html',
        'htmldjango',
        'edge',
        'eelixir', -- vim ft
        'elixir',
        'ejs',
        'erb',
        'eruby', -- vim ft
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        'php',
        'razor',
        'slim',
        'twig',
        -- css
        'css',
        'less',
        'postcss',
        'sass',
        'scss',
        'stylus',
        'sugarss',
        -- js
        'javascript',
        'javascriptreact',
        'reason',
        'rescript',
        'typescript',
        'typescriptreact',
        -- mixed
        'vue',
        'svelte',
        'templ',
    },
    root_markers = { 'package.json' },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("qmlls")
