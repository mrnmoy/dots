local M = {}
function M.setup()
	local config = require("nvim-treesitter.configs")
	config.setup({
		ensure_installed = {
			"lua",
			"vim",
			"regex",
			"bash",
			"markdown",
			"markdown_inline",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"astro",
			"norg",
			"json",
			"yaml",
			"python",
			"gitignore",
			"git_config",
			"jsonc",
			"kotlin",
		},
		auto_install = true,
		indent = { enable = false }, --BUG: THIS OPTION ALSO COUSES "STACK CORRUPTION ERROR WHEN ENABLED"

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		-- Hyprlang LSP
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = { "*.hl", "hypr*.conf" },
			callback = function(event)
				print(string.format("starting hyprls for %s", vim.inspect(event)))
				vim.lsp.start({
					name = "hyprlang",
					cmd = { "hyprls" },
					root_dir = vim.fn.getcwd(),
				})
			end,
		}),
	})
end

return M
