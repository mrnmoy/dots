return {
	--Codeium AI
	{
		"Exafunction/codeium.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "hrsh7th/nvim-cmp",
		},
		opts = {},
	},
	-- ChatGPT
	-- {
	-- "jackMort/ChatGPT.nvim",
	-- event = "VeryLazy",
	-- config = function()
	--   require("chatgpt").setup({
	--     api_key_cmd = "pass show api/openai",
	--   })
	-- end,
	-- dependencies = {
	--   "MunifTanjim/nui.nvim",
	--   "nvim-lua/plenary.nvim",
	--   "folke/trouble.nvim",
	--   "nvim-telescope/telescope.nvim"
	-- }
	-- },
	--  Gemini
	-- {
	--   'kiddos/gemini.nvim',
	--   build = { 'pip install -r requirements.txt', ':UpdateRemotePlugins' },
	--   opts = {},
	-- },
}
