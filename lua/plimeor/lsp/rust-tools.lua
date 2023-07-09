return {
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local lsp_utils = require("plimeor.lsp.lsp-utils")
		local rt = require("rust-tools")

		rt.setup({
			server = {
				on_attach = function(client, bufnr)
					lsp_utils.on_attach(client, bufnr)

					vim.keymap.set(
						"n",
						"J",
						require("rust-tools").join_lines.join_lines,
						{ buffer = bufnr, desc = "Rust Join Lines" }
					)
				end,
				capabilities = lsp_utils.get_lsp_capabilities(),
			},
		})
	end,
}
