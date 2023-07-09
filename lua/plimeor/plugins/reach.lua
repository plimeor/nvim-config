return {
	"toppair/reach.nvim",
	config = function()
		local reach = require("reach")

		vim.keymap.set("n", "<leader>gb", reach.buffers, {
			desc = "Go To Buffers",
		})

		reach.setup({
			notifications = true,
		})
	end,
}
