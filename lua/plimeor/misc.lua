local M = {}

M.plugins = {
	-- automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
	"tpope/vim-sleuth",
	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim",  opts = {} },

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	--  show symbols on winbar
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			theme = "tokyonight",
		},
	},
	{
		-- lua with packer.nvim
		"max397574/better-escape.nvim",
		opts = {
			mapping = { "jk", "jj", "kj" }, -- a table with mappings to use
			timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
			clear_empty_lines = false, -- clear line after escaping if there is only whitespace
			keys = function()
				return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
			end,
		},
	},
}

return M
