return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					-- ["*"] = { "codespell" },
					-- ["_"] = { "trim_whitespace" },
					bash = { "beautysh" },
					javascript = { "prettierd", stop_after_first = true },
					typescript = { "prettierd", stop_after_first = true },
					javascriptreact = { "prettierd", stop_after_first = true },
					typescriptreact = { "prettierd", stop_after_first = true },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					lua = { "stylua", "prettierd" },
					python = { "isort", "black" },
					c = { "clangd" },
					cpp = { "clangd" },
					arduino = { "clangd" },
					ino = { "clangd" },
					pde = { "clangd" },
					-- c = { "clang_format" },
					-- cpp = { "clang_format" },
					-- arduino = { "clang_format" },
					kotlin = { "ktfmt" },
					-- kotlin = { "ktlint" },
					-- kotlin = { "kotlin_language_server" },
				},
				formatters = {
					ktfmt = {
						prepend_args = { "--kotlinlang-style" },
					},
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 5000,
					-- timeout_ms = 500,
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>L", function()
				conform.format({
					lsp_fallback = true,
					async = true,
					timeout_ms = 5000,
				})
			end, { desc = "format buffer" })
		end,
	},
	-- {
	-- 	"Wansmer/treesj",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	opts = {},
	-- },
}
