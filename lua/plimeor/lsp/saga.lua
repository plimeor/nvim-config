return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		--Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = {
				enable = false,
			},
		})
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Definition" })
		vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Goto Definition" })
		vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
		vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { desc = "Goto References" })

		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Document" })

		vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })

		-- diagnose
		vim.keymap.set(
			"n",
			"<C-k>",
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			{ desc = '"Go to previous diagnostic message" ' }
		)

		vim.keymap.set(
			"n",
			"<C-j>",
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			{ desc = "Go to next diagnostic message" }
		)

		vim.keymap.set(
			"n",
			"<leader>e",
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			{ desc = "Open floating diagnostic message" }
		)
	end,
}
