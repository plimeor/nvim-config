---Get the current element i.e. tab or buffer
---@return number
local function get_current_element()
	local config = require("bufferline.config")

	if config:is_tabline() then
		return vim.api.nvim_get_current_tabpage()
	end

	return vim.api.nvim_get_current_buf()
end

local function close_current_element()
	require("bufferline.commands").unpin_and_close(get_current_element())
end

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	config = function()
		-- Move to previous/next
		vim.keymap.set("n", "<C-,>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true })
		-- Move to revious/next
		vim.keymap.set("n", "<C-.>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true })
		vim.keymap.set("n", "<C-/>", close_current_element, { noremap = true })

		require("bufferline").setup({
			options = {
				show_close_icon = false,
				show_buffer_close_icons = false,
				separator_style = "slope",
				indicator = {
					style = "underline",
				},
				diagnostics = "nvim_lsp",
				---@diagnostic disable-next-line: unused-local
				diagnostics_indicator = function(count, level, _diagnostics_dict, _context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})
	end,
}
