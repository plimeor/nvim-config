-- Update this path
local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find("Windows") then
	codelldb_path = extension_path .. "adapter\\codelldb.exe"
	liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
else
	-- The liblldb extension is .so for linux and .dylib for macOS
	liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

return {
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local lsp_utils = require("plimeor.lsp.lsp-utils")
		local rt = require("rust-tools")

		rt.setup({
			server = {
				on_attach = function(client, bufnr)
					lsp_utils.on_attach(client, bufnr)

					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })

					vim.keymap.set("n", "J", rt.join_lines.join_lines, { buffer = bufnr, desc = "Rust Join Lines" })
				end,
				capabilities = lsp_utils.get_lsp_capabilities(),
			},

			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		})
	end,
}
