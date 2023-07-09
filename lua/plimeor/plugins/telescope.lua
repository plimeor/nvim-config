return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		config = function()
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		-- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
		"nvim-telescope/telescope-frecency.nvim",
		branch = "master",
		config = function()
			pcall(require("telescope").load_extension, "frecency")

			vim.keymap.set("n", "<leader>?", function()
				require("telescope").extensions.frecency.frecency({ workspace = "CWD" })
			end, { desc = "[?] Find recently opened files" })
		end,
		dependencies = { "kkharji/sqlite.lua" },
	},
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- See `:help telescope.builtin`
			-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>F", require("telescope.builtin").live_grep, { desc = "[F] Find in Files" })
			vim.keymap.set("n", "<leader>k", require("telescope.builtin").find_files, { desc = "[k] Files" })
			vim.keymap.set("n", "<leader>K", require("telescope.builtin").commands, { desc = "[K] Actions" })
			vim.keymap.set(
				"n",
				"<leader>o",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Workspace Symbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>O",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "Document Symbols" }
			)

			vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
			vim.keymap.set("n", "g?", require("telescope.builtin").help_tags, { desc = "[H]elps" })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>sw",
			-- 	require("telescope.builtin").grep_string,
			-- 	{ desc = "[S]earch current [W]ord" }
			-- )
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>sd",
			-- 	require("telescope.builtin").diagnostics,
			-- 	{ desc = "[S]earch [D]iagnostics" }
			-- )

			local telescopeConfig = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			table.insert(vimgrep_arguments, "--follow") -- follow symlinks

			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						height = 0.7,
					},
				},
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git" },
					},
				},
			})
		end,
	},
}
