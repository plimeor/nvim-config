local M = {}

local im_select_cmd = "im-select"
local im_select_default = "com.apple.keylayout.ABC"

local function resotre_im()
	return vim.fn.system({ im_select_cmd, im_select_default })
end

M.setup = function()
	local group_id = vim.api.nvim_create_augroup("im-select", { clear = true })

	vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
		callback = resotre_im,
		group = group_id,
	})
end

return M
