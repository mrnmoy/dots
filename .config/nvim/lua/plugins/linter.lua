return {
	{
		"mfussenegger/nvim-lint",
		-- enabled = false,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "pylint" },
				cpp = { "clangtidy" },
				c = { "clangtidy" },
				-- kotlin = { "ktlint" },
				-- kotlin = { "kotlin_lsp" },
				-- kotlin = { "kotlin_language_server" },
				bash = { "bash" },
				fish = { "fish" },
				zsh = { "zsh" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "classic",
				transparent_bg = true, -- Set the background of the diagnostic to transparent
				transparent_cursorline = false,
			})
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
}
