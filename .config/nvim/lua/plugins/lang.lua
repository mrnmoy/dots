return {
	--HTML
	-- {
	-- 	"mattn/emmet-vim",
	-- 	enabled = false,
	-- },

	--Tailwind
	{
		{
			"luckasRanarison/tailwind-tools.nvim",
			name = "tailwind-tools",
			build = ":UpdateRemotePlugins",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-telescope/telescope.nvim",
				"neovim/nvim-lspconfig",
			},
			opts = {
				server = {
					override = false,
				},
				conceal = {
					enabled = true,
				},
			},
		},
	},

	-- Javascript / Typescript
	{
		-- {
		--   "windwp/nvim-ts-autotag",
		--   config = function()
		--     require("nvim-ts-autotag").setup()
		--   end,
		-- },
	},

	-- Note Taking

	{
		{
			"epwalsh/obsidian.nvim",
			enabled = false,
			version = "*",
			lazy = true,
			ft = "markdown",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {
				workspaces = {
					{
						name = "personal",
						path = "~/notes",
					},
					{
						name = "work",
						path = "~/notes/work",
					},
				},
			},
		},
		{
			"nvim-neorg/neorg",
			enabled = false,
			lazy = false,
			version = "*",
			build = ":Neorg sync-parsers",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			},
		},
	},

	--Markdown
	{
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function()
				vim.fn["mkdp#util#install"]()
			end,
		},
		{
			"b0o/schemastore.nvim",
		},
	},
}
