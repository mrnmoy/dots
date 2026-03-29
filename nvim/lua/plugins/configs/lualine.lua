local M = {}

function M.setup()
	require("lualine").setup({
		--NOTE: Uniqe separators           
		options = {
			-- theme = "catppuccin",
			-- theme = custom,
			theme = "auto",
			globalstatus = true,
			-- component_separators = { left = "", right = "" },
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
		},
		sections = {
			lualine_a = {
				{
					"hostname",
					icon = { "󰣇", align = "left" },
					separator = { left = "" },
					right_padding = 2,
				},
			},
			lualine_b = {
				{ "branch", icon = { "󰊢", align = "left" } },
			},
			lualine_c = {
				"%=",
				-- {require('auto-session.lib').current_session_name},
				-- { "filesize", icon = { "󰈔", align = "left" } },
			},
			lualine_x = {
				{ "diagnostics" },
				{ "diff" },
			},
			lualine_y = {
				{ "selectioncount" },
				{ "progress" },
			},
			lualine_z = {
				{
					"location",
					icon = { "󰦨", align = "right" },
					separator = { right = "" },
					left_padding = 2,
				},
			},
		},
		tabline = {
			lualine_a = {
				{
					"buffers",
					separator = { left = "", right = "" },
					symbols = {
						modified = " ●",
						alternate_file = "",
						directory = "",
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {
				{
					"tabs",
					separator = { left = "", right = "" },
					left_padding = 2,
					right_padding = 2,
					symbols = {
						modified = " ●",
						alternate_file = "",
						directory = "",
					},
				},
			},
		},
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					"navic",
					color_correction = nil,
					navic_opts = nil,
					separator = { left = "", right = "" },
					padding = { left = 4 },
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"lazy",
			"mason",
			"fzf",
			"oil",
			"neo-tree",
			"trouble",
		},
	})
end

return M
