return {
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function()
			local lsp_utils = require("plimeor.lsp.lsp-utils")

			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {
				-- 	["rust-analyzer"] = {
				-- 		check = {
				-- 			command = "clippy",
				-- 		},
				-- 		diagnostics = {
				-- 			experimental = {
				-- 				enable = true,
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- tsserver = {},

				lua_ls = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							-- Do not send telemetry data containing a randomized but unique identifier
							enable = false,
						},
					},
				},
			}

			-- Setup neovim lua configuration
			require("neodev").setup()

			local on_attach = lsp_utils.on_attach
			local capabilities = lsp_utils.get_lsp_capabilities()

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
			})
		end,
	},
	require("plimeor.lsp.trouble"),
	require("plimeor.lsp.saga"),
	require("plimeor.lsp.null-ls"),
	require("plimeor.lsp.rust-tools"),
}
