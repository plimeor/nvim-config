return {
	"folke/noice.nvim",
	event = "VeryLazy",

	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		local config = require("noice.config")
		local noice = require("noice")

		noice.setup({
			views = {
				cmdline_popup = {
					position = {
						row = "42%",
					},
				},
			},
			presets = {
				command_palette = true,
				long_message_to_split = true,
			},
			routes = {
				{
					filter = {
						any = {
							{ event = "msg_show", kind = "", find = "written" },
							{ event = "lsp", kind = "progress", find = "code_action" },
						},
					},
					opts = { skip = true },
				},
			},
		})
	end,
}
