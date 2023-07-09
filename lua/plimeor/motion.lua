local M = {}

M.plugins = {
	{

		"tpope/vim-repeat",
		priority = 1000,
	},
	"michaeljsmith/vim-indent-object",
	"wellle/targets.vim",
	-- https://github.com/mg979/vim-visual-multi
	"mg979/vim-visual-multi",
	-- https://github.com/tpope/vim-surround
	"tpope/vim-surround",
	{
		-- https://github.com/ggandor/leap.nvim
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "nv",
				multiline = true,
				opts = {},
			})
		end,
	},
}

return M
