return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/popup.nvim",
	},
	keys = {
		{ "<C-p>", "<cmd>Telescope find_files hidden=true<CR>", desc = "Find files" },
		{ "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<Leader>fa", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{ "<Leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "\\", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "<Leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
		{ "<Leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
		{ "gr", function() require("telescope.builtin").lsp_references() end, desc = "LSP references" },
		{ "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "LSP definitions" },
		{ "gD", function() require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" }) end, desc = "LSP definitions (vsplit)" },
		{ "gX", function() require("telescope.builtin").lsp_definitions({ jump_type = "split" }) end, desc = "LSP definitions (split)" },
		{ "<Leader>/", function() require("telescope").extensions.live_grep_args.live_grep_args() end, desc = "Live grep (args)" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		local custom_actions = {}
		function custom_actions.fzf_multi_select(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local num_selections = #picker:get_multi_selection()

			if num_selections > 1 then
				actions.send_selected_to_qflist(prompt_bufnr)
				actions.open_qflist()
			else
				actions.file_edit(prompt_bufnr)
			end
		end

		telescope.setup({
			defaults = {
				selection_caret = " ❯ ",
				entry_prefix = "  ",
				previewer = false,
				layout_strategy = "bottom_pane", -- Puts the window at the bottom
				layout_config = {
					prompt_position = "bottom", -- Puts the cursor at the bottom of the window
					height = 0.99,
				},
				mappings = {
					i = {
						["<esc>"] = actions.close, -- Close on escape
						["<cr>"] = custom_actions.fzf_multi_select,
					},
					n = {
						["<cr>"] = custom_actions.fzf_multi_select,
					},
				},
				path_display = { "truncate" },
			},
			pickers = {
				find_files = {
					previewer = false,
				},
				buffers = {
					sort_lastused = true,
					previewer = false,
					height = 0.99,
					mappings = {
						i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
						n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
					},
				},
				lsp_references = {
					show_line = false,
				}
			},
		})
	end,
}
