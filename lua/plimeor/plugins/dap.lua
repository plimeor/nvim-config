return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "Debugger Continue" })

			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end, { desc = "Debugger Setp Over" })

			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "Debugger Step Into" })

			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "Debugger Step Out" })

			vim.keymap.set("n", "<leader>b", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Debugger Toggle Breakpoint" })

			vim.keymap.set("n", "<leader>B", function()
				require("dap").set_breakpoint()
			end, { desc = "Debugger Set Breakpoint" })

			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Debughger Set Breakpoint" })

			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Debugger Repl" })

			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end, { desc = "Debugger Run Last" })

			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Debugger Hover" })

			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "Debugger Preview" })

			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "Debugger Frames" })

			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Debugger Scopes" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
