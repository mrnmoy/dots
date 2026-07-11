return {
	{
		"folke/which-key.nvim",
		-- event = "VeryLazy",
		config = function()
			require("plugins.configs.mappings").setup()
		end,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	--NOTE: Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-github.nvim",
			"andrew-george/telescope-themes",
			-- "polirritmico/telescope-lazy-plugins.nvim",
		},
		config = function()
			require("plugins.configs.telescope").setup()
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			menu = {
				width = vim.api.nvim_win_get_width(0) - 10,
			}
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.configs.oil").setup()
		end,
	},

	--NOTE: replacement for oil.nvim
	-- {
	--   'echasnovski/mini.files',
	--   version = '*',
	--   opts = {},
	-- },

	--NOTE: Move Nvim
	{
		"fedepujol/move.nvim",
		opts = {},
	},

	--NOTE: Replace w, e, b motion
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = {
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
		},
	},
}
