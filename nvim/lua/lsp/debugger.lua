return {
	{
		"mfussenegger/nvim-dap",
		conig = function()
			require("plugins.configs.debugger").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
}
