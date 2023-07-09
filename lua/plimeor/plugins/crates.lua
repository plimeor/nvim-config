return {
	"saecki/crates.nvim",
	tag = "v0.3.0",
	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	config = function()
		require("crates").setup({})
	end,
}
