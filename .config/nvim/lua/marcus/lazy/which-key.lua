return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>f",  group = "file/find" },
			{ "<leader>g",  group = "git" },
			{ "<leader>s",  group = "search" },
			{ "<leader>rh", require("marcus.keymap").toggle_substitute_help, desc = "Show Replace Cheat Sheet" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
		{
			"<leader>sk",
			"<cmd>Telescope keymaps<cr>",
			desc = "Search Keymaps (Telescope)",
		},
	},
}
