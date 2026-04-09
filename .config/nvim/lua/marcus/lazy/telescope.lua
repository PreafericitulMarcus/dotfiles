return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup {
			defaults = {
				prompt_prefix = "-> ",
				selection_caret = "> ",
				file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
				file_ignore_patterns = {
					".git/",
					"plugged/",
					"node_modules/",
					"undodir/",
					"bin/.*%.class",
					"target/",
					"Migrations/"

				}
			},
			extensions = {
				fzy_native = {
					fuzzy = true,
					override_generic_sorter = false,
					override_file_sorter = true,
					case_mode = "smart_case"
				}
			}
		}
		telescope.load_extension('fzy_native')

		-- Maps
		local bind = require("marcus.keymap").bind
		local nnoremap = bind('n', { noremap = true, silent = true })

		-- Now call it with (lhs, rhs, { desc = "..." })
		nnoremap('<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })

		nnoremap('<leader>ps', function()
			require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
		end, { desc = "Project Search (Grep)" })

		nnoremap('<leader>lg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
		nnoremap('<leader>gf', require('telescope.builtin').git_files, { desc = "Find Git Files" })
		nnoremap('<leader>bf', require('telescope.builtin').buffers, { desc = "List Open Buffers" })
		nnoremap('<leader>km', require('telescope.builtin').keymaps, { desc = "Search Keymaps" })

		-- For the Control mapping
		nnoremap('<C-_>', function()
			require('telescope.builtin').current_buffer_fuzzy_find({
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top" }
			})
		end, { desc = "Fuzzy Search in Buffer" })
	end,
}
