local function install_plugin_manager()
	-- Install package manager
	--    https://github.com/folke/lazy.nvim
	--    `:help lazy.nvim.txt` for more info
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)
end

local function install_plugins()
	require("lazy").setup({

		-- theme, ui
		require("plimeor.plugins.theme"),
		require("plimeor.plugins.bufferline"),
		require("plimeor.plugins.lualine"),
		require("plimeor.plugins.indent-blankline"),
		require("plimeor.plugins.lspkind"),
		require("plimeor.plugins.vim-illuminate"),

		-- lua development
		require("plimeor.plugins.neodev"),

		-- file navigate
		require("plimeor.file-explorer.neo-tree"),
		require("plimeor.plugins.telescope"),

		require("plimeor.plugins.treesitter"),

		require("plimeor.motion").plugins,

		require("plimeor.complete"),

		require("plimeor.lsp.lsp"),

		require("plimeor.navigate").plugins,
		require("plimeor.misc").plugins,
		require("plimeor.git").plugins,

		require("plimeor.plugins.ufo"),
		require("plimeor.plugins.reach"),
		require("plimeor.plugins.noice"),
		require("plimeor.plugins.crates"),

		-- terminal
		require("plimeor.plugins.terminal"),

		-- debugger
		require("plimeor.plugins.dap"),
	}, {})
end

require("plimeor.core")
require("plimeor.im-select").setup()

install_plugin_manager()

install_plugins()
