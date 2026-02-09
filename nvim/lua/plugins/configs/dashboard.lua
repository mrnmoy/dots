local M = {}
function M.setup()
	local db = require("dashboard")
	-- vim.cmd("silent !~/.config/nvim/image-dash.sh &")

	db.setup({
		-- theme = "doom",
		-- config = {
		-- 	header = {},
		-- 	center = {
		-- 		{ icon = " ", desc = "New File", action = "enew", key = "n" },
		-- 		{ icon = " ", desc = "Recently Used Files", action = "Telescope oldfiles", key = "r" },
		-- 	},
		-- 	footer = { "Bhishma welcomes you." },
		-- },
	})
end
return M
