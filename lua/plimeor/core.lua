vim.cmd("language en_US.UTF-8")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- appearance
vim.o.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- highlight results while incsearch
local incsearch_highlight_group = vim.api.nvim_create_augroup("incsearch_highlight", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {
	callback = function()
		vim.opt.hlsearch = true
	end,
	pattern = { [[/]], [[\?]] },
	group = incsearch_highlight_group,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		vim.opt.hlsearch = false
	end,
	pattern = { [[/]], [[\?]] },
	group = incsearch_highlight_group,
})

-- caches
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- keep scroll-y center
vim.opt.scrolloff = 999

vim.opt.cmdheight = 1

-- mouse mode
vim.o.mouse = "a"

-- sync clipboard between system and neovim.
-- see `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

vim.opt.shell = "fish"

-- decrease update time
vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300

-- set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})
