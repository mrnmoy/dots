return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"mason-org/mason.nvim",
		{
			"mason-org/mason-lspconfig.nvim",
			dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
		},
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	-- event = { "BufReadPre", "BufNewFile" },
	vim.lsp.set_log_level("off"),
	-- vim.lsp.set_log_level("debug"),

	opts = {
		servers = {
			lua_ls = {},
			kotlin_lsp = {
				kotlin = {
					debugAdapter = {
						enabled = false,
					},
					languageServer = {
						debugAttach = { enabled = false, autoSuspend = false },
					},
				},
			},
		},
	},

	config = function(_, opts)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- vim.lsp.config("kotlin_lsp", {
		-- 	cmd = { "" },
		-- })
		-- vim.lsp.enable("kotlin_lsp")

		-- local lspconfig = require("lspconfig")
		-- for server, config in pairs(opts.servers) do
		-- 	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
		-- 	lspconfig[server].setup(config)
		-- end

		-- vim.filetype.add({
		-- 	pattern = {
		-- 		["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
		-- 	},
		-- })

		-- local MY_FQBN = "esp8266:esp8266:nodemcuv2"
		-- lspconfig.arduino_language_server.setup({
		-- 	cmd = {
		-- 		"arduino-language-server",
		-- 		"-cli-config",
		-- 		"~/.config/arduino/arduino-cli.yaml",
		-- 		-- "-fqbn",
		-- 		-- MY_FQBN,
		-- 	},
		-- })

		-- vim.lsp.disable("kotlin_language_server")
		-- vim.lsp.disable("kotlin_lsp")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- automatic_enable = true,
			automatic_installation = true,
			ensure_installed = {
				"vimls",
				"lua_ls",
				"html",
				"cssls",
				"ts_ls",
				"jsonls",
				"bashls",
				"yamlls",
				"tailwindcss",
				"emmet_ls",
				"astro",
				"clangd",
				"arduino_language_server",
				"hyprls",
				"sqlls",
				"pylsp",
				"vacuum",
				-- "nix_ls",
				"marksman",
				-- "kotlin_lsp",
				-- "kotlin_language_server",
				-- "java_language_server", -- need java 18
				-- "gradle_ls",
				"cmake",
				"astro",
				-- "asm_lsp", --need rustup
				"angularls",
				"harper_ls",
				"docker_compose_language_service",
				"dockerls",
				"qmlls", --qt
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettierd",
				"stylua",
				"eslint_d",
				"pylint",
				"isort",
				"black",
				"js-debug-adapter",
				-- "ktlint",
				"ktfmt",
				"qmlls",
			},
		})
	end,
}
