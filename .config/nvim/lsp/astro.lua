-- .config/nvim/lsp/astro.lua
local function get_tsserver_path(root_dir)
    local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
    return project_root and vim.fs.joinpath(project_root, "node_modules", "typescript", "lib") or ""
end

return {
    cmd = {
        "astro-ls",
        "--stdio",
    },
    filetypes = {
        "astro",
        "ts",
    },
    root_markers = {
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
        ".git",
    },
    init_options = {
        typescript = {},
    },
    before_init = function(_, config)
        if not config.init_options.typescript.tsdk then
            config.init_options.typescript.tsdk = get_tsserver_path(config.root_dir)
        end
    end,
}
