local M = {}

M.plugins = {
	"mhinz/vim-startify",
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup({
				global_settings = {
					-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
					save_on_toggle = false,

					-- saves the harpoon file upon every change. disabling is unrecommended.
					save_on_change = true,

					-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
					enter_on_sendcmd = false,

					-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
					tmux_autoclose_windows = false,

					-- filetypes that you want to prevent from adding to the harpoon list menu.
					excluded_filetypes = { "harpoon" },

					-- set marks specific to each git branch inside git repository
					mark_branch = false,
				},
			})
			vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, { desc = "Harpoon mark" })
			vim.keymap.set("n", "<leader><leader>", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon menu" })

			require("telescope").load_extension("harpoon")
		end,
	},
	{
		"gennaro-tedesco/nvim-possession",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		config = function()
			local possession = require("nvim-possession")

			possession.setup({
				autoload = false,
				autosave = true,
				autoswitch = {
					enable = true,
				},
			})

			vim.keymap.set("n", "<leader>sl", possession.list, { desc = "session list" })
			vim.keymap.set("n", "<leader>sn", possession.new, { desc = "session new" })
			vim.keymap.set("n", "<leader>su", possession.update, { desc = "session update" })
			vim.keymap.set("n", "<leader>sd", possession.delete, { desc = "session delete" })
		end,
	},
}

return M
