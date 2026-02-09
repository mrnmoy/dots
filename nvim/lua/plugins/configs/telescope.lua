local M = {}
function M.setup()
	local ts = require("telescope")
	local lx = require("telescope").load_extension
	local themes = require("telescope.themes")
	local action = require("telescope.actions")

	ts.setup({
		defaults = {
			prompt_prefix = "  ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			results_title = false,
			sorting_strategy = "ascending",
			preview = { hide_on_startup = true },
			layout_strategy = "vertical", -- HORIZONTAL, VERTICAL, FLEX
			layout_config = {
				vertical = {
					prompt_position = "top",
					preview_cutoff = 10,
					preview_height = 0.4,
				},
			},
		},
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
			find_files = {
				-- theme = "dropdown", -- cursor, ivy, dropdown
			},
		},
		extensions = {
			themes = {
				-- layout_config = {
				--   horizontal = {
				--     width = 0.8,
				--     height = 0.7,
				--   },
				-- },
				enable_previewer = true,
				enable_live_preview = true,
				persist = {
					enabled = true,
					path = vim.fn.stdpath("config") .. "/lua/core/theme.lua",
				},
			},
			package_info = {
				theme = "ivy",
			},
		},
		mappings = {
			n = {
				["q"] = action.close,
				["o"] = require("telescope.actions.layout").toggle_preview,
				["<C-q>"] = require("telescope.actions").close,
			},
			i = {
				["<C-o>"] = require("telescope.actions.layout").toggle_preview,
			},
		},
	})
	lx("noice")
	lx("ui-select")
	lx("media_files")
	lx("project")
	lx("themes")
	lx("zoxide")
	lx("package_info")
	-- lx("lazy_plugins")
	-- lx('colorscheme')
	-- lx("fzf")
	-- lx("fzy_native")
	-- lx('dap')
end
return M
