local M = {}

local auto_format_group = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto Implementation" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })

	-- create format command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	-- manual format
	vim.keymap.set({ "n", "v" }, "<leader>L", vim.lsp.buf.format)

	-- auto format
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = auto_format_group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = auto_format_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

M.get_lsp_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	return capabilities
end

return M
