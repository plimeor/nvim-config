return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			-- See https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
			sources = {
				-- common
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.formatting.codespell,

				-- lua
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.diagnostics.luacheck.with({
				-- 	args = {
				-- 		"--default-config",
				-- 		"~/.config/luacheck/.luacheckrc",
				-- 	},
				-- }),
				--
				-- eslint
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.code_actions.eslint_d,

				-- typescript
				null_ls.builtins.formatting.prettierd,
			},
		})
	end,
}
