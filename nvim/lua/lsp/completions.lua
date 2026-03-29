return {
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
			},
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		opts = {
			keymap = { preset = "enter" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				ghost_text = {
					enabled = false,
					show_with_menu = false,
				},
				menu = {
					-- border = 'single',
					-- auto_show = false,
					draw = {
						-- columns = {
						-- 	{ "label", "label_description", gap = 1 },
						-- 	{ "kind_icon", "kind" },
						-- },
					},
				},
				documentation = {
					auto_show = false,
					--   window = { border = 'single' }
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
			},
			signature = {
				enabled = true,
				-- window = { border = 'single' }
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				per_filetype = { sql = { "dadbod" } },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			fuzzy = {
				implementation = "rust", -- prefer_rust_with_warning, prefer_rust, rust, lua
				sorts = {
					"exact",
					-- defaults
					"score",
					"sort_text",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
