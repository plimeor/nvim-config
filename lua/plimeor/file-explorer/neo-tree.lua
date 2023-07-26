return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function(_, opts)
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		vim.keymap.set("n", "<leader>f", "<cmd>Neotree toggle filesystem reveal<CR>", { noremap = true, silent = true })

		require("neo-tree").setup({
			sort_case_insensitive = true, -- used when sorting files and directories in the tree
			sources = {
				"filesystem",
				"git_status",
				"document_symbols",
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem", display_name = " 󰉓 Files " },
					{ source = "git_status", display_name = " 󰊢 Git " },
					{ source = "document_symbols", display_name = "  Symbols " },
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					-- macOs: open file in default application in the background.
					-- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
					vim.api.nvim_command("silent !open -g " .. path)
					-- Linux: open file in default application
					vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
				end,
				live_grep = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").live_grep({
						cwd = path,
						search_dirs = { path },
						attach_mappings = function()
							require("neo-tree.sources.common.commands").close_window(state)
							return true
						end,
					})
				end,
				parent_node = function(state)
					local node = state.tree:get_node()
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end,
				copy_path = function(state)
					local node = state.tree:get_node()
					print(node.path)
				end,
			},
			window = {
				position = "float",
				mappings = {
					["<C-,>"] = "prev_source",
					["<C-.>"] = "next_source",
					["o"] = "toggle_node",
					["F"] = "live_grep",
					["O"] = "system_open",
					["P"] = "parent_node",
					["Y"] = "copy_path",
				},
			},
			default_component_configs = {
				name = {
					highlight_opened_files = true,
				},
				modified = {
					symbol = "",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "A",
						deleted = "D",
						modified = "M",
						renamed = "R",
						-- Status type
						untracked = "??",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			filesystem = {
				follow_current_file = true,
				filtered_items = {
					hide_dotfiles = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					hide_by_pattern = {},
					never_show = {
						".git",
						".DS_Store",
					},
				},
			},

			document_symbols = {
				follow_cursor = true,
				kinds = {
					File = { icon = "󰈙", hl = "Tag" },
					Namespace = { icon = "󰌗", hl = "Include" },
					Package = { icon = "󰏖", hl = "Label" },
					Class = { icon = "󰌗", hl = "Include" },
					Property = { icon = "󰆧", hl = "@property" },
					Enum = { icon = "󰒻", hl = "@number" },
					Function = { icon = "󰊕", hl = "Function" },
					String = { icon = "󰀬", hl = "String" },
					Number = { icon = "󰎠", hl = "Number" },
					Array = { icon = "󰅪", hl = "Type" },
					Object = { icon = "󰅩", hl = "Type" },
					Key = { icon = "󰌋", hl = "" },
					Struct = { icon = "󰌗", hl = "Type" },
					Operator = { icon = "󰆕", hl = "Operator" },
					TypeParameter = { icon = "󰊄", hl = "Type" },
					StaticMethod = { icon = "󰠄 ", hl = "Function" },
				},
			},
		})
	end,
}
