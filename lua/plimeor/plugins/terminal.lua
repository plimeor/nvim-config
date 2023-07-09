local lazygit

local function toggle_lazygit()
	local Terminal = require("toggleterm.terminal").Terminal
	if not lazygit then
		lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	end

	lazygit:toggle()
end

local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("n", "q", "<cmd>q<CR>", opts)
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	-- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	-- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	-- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	-- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	-- vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		open_mapping = [[<c-\>]],
		direction = "float",
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.keymap.set("n", "<leader>gg", toggle_lazygit)

		vim.api.nvim_create_autocmd("TermOpen", {
			group = vim.api.nvim_create_augroup("ToggleTermMapping", { clear = true }),
			pattern = "term://*",
			callback = set_terminal_keymaps,
		})
	end,
}
