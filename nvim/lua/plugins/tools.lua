return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		lazy = true,
		config = function()
			require("plugins.configs.treesitter").setup()
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		event = "BufWinEnter",
		setup = function()
			vim.cmd([[packadd telescope.nvim]])
		end,
	},
	-- {
	--   "folke/trouble.nvim",
	--   branch = "dev",
	--   dependencies = "nvim-tree/nvim-web-devicons",
	--   opts = {},
	-- },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("Comment").setup({
				pre_hook = function()
					return vim.bo.commentstring
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
	{
		"numToStr/FTerm.nvim",
		opts = {
			dimensions = {
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,
			},
		},
	},

	{
		"kdheepak/lazygit.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- {
	-- 	"altermo/ultimate-autopair.nvim",
	--    -- enabled = false,
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	-- branch = "v0.6",
	-- 	opts = {},
	-- },

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	{
		"rmagatti/auto-session",
		enabled = false,
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_session_enable_last_session = true,
				session_lens = {
					buftypes_to_ignore = {},
					load_on_setup = true,
				},
			})
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		end,
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			"nanotee/zoxide.vim",
			"nvim-lua/popup.nvim",
		},
		opts = {},
	},

	--NOTE: Live edit html css javascript
	{
		"turbio/bracey.vim",
		enabled = false,
		cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
		build = "npm install --prefix server",
	},

	{
		"aurum77/live-server.nvim",
		enabled = false,
		run = function()
			require("live_server.util").install()
		end,
		cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
	},

	{
		"max397574/colortils.nvim",
		enabled = false,
		cmd = "Colortils",
		config = function()
			require("colortils").setup({
				register = "+",
				color_preview = "█ %s",
				default_format = "hex",
				border = "rounded",
				mappings = {
					increment = "l",
					decrement = "h",
					increment_big = "L",
					decrement_big = "H",
					min_value = "0",
					max_value = "$",
					set_register_default_format = "<cr>",
					set_register_cjoose_format = "g<cr>",
					replace_default_format = "<m-cr>",
					replace_choose_format = "g<m-cr>",
					export = "E",
					set_value = "c",
					transparency = "T",
					choose_background = "B",
				},
			})
		end,
	},
	{
		"ziontee113/color-picker.nvim",
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		opts = {},
	},

	{
		"vuki656/package-info.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},

	--TEST:
	-- {
	--   "cshuaimin/ssr.nvim",
	-- },

	--NOTE: Nerd Icon Picker
	{
		"ziontee113/icon-picker.nvim",
		opts = {},
	},

	--NOTE: CommentBox
	{
		"LudoPinelli/comment-box.nvim",
	},
	--NOTE: Octo nvim
	{
		"pwntester/octo.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- OR 'ibhagwan/fzf-lua',
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	--NOTE: Arduino
	{ "stevearc/vim-arduino" },
}
