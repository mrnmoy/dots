return {
	{
		"compose.nvim",
		enabled = false,
		dir = "~/compose.nvim",
		config = function()
			require("compose").setup()
		end,
	},
	{
		"kmp.nvim",
		enabled = false,
		dir = "~/kmp.nvim",
		config = function()
			require("kmp").setup()
		end,
	},

	{
		"3rd/image.nvim",
		build = false,
		opts = {
			processor = "magick_cli",
		},
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"ThePrimeagen/vim-be-good",
	},

	--TEST:
	{
		"romgrk/nvim-treesitter-context",
		enabled = false,
		config = function()
			require("treesitter-context").setup({
				enable = true,
				throttle = true,
				max_lines = 0,
				patterns = {
					default = {
						"class",
						"function",
						"method",
					},
				},
			})
		end,
	},

	{
		"ariedov/android-nvim",
		enabled = false,
		config = function()
			vim.g.android_sdk = "/opt/android-sdk"
			require("android-nvim").setup()
		end,
	},
}
