return {
	{
		"md3.nvim",
		dir = "~/md3.nvim",
		-- name = "md3",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			require("md3").setup()
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			default_integrations = true,
			term_colors = true,
			transparent_background = true,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
			},
			color_overrides = {
				mocha = {
					-- base = "#000000",
					-- mantle = "#000000",
					-- crust = "#000000",
				},
			},
			integrations = {
				cmp = true,
				ufo = true,
				gitsigns = true,
				neotree = true,
				noice = true,
				treesitter = true,
				notify = true,
				dashboard = true,
				flash = true,
				harpoon = true,
				lsp_trouble = true,
				which_key = true,
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				indent_blankline = {
					enabled = true,
					scope_color = "",
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		},
	},

	{
		"baliestri/aura-theme",
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		end,
	},

	{
		"0xstepit/flow.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
	},

	{
		"folke/tokyonight.nvim",
		"EdenEast/nightfox.nvim",
		"projekt0n/github-nvim-theme",
		"rebelot/kanagawa.nvim",
		"rose-pine/neovim",
		"scottmckendray/cyberdream.nvim",
		"sainnhe/everforest",
		"navarasu/onedark.nvim",
		"sainnhe/gruvbox-material",
		"sainnhe/sonokai",
		"Mofiqul/dracula.nvim",
	},
}
