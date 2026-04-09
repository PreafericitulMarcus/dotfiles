return {
	'nvim-flutter/flutter-tools.nvim',
	lazy = false,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- Optional: Better UI for selecting devices
		'mfussenegger/nvim-dap',
	},
	config = function()
		require("flutter-tools").setup({
			ui = {
				border = "rounded",
				notification_style = "plugin",
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
			},
			lsp = {
				color = {
					enabled = true,
					background = true,
				},
			},
		})

		-- Flutter Keymaps (Only active when the plugin loads)
		local keymap = vim.keymap.set
		keymap("n", "<leader>fs", "<cmd>FlutterRun<cr>", { desc = "Flutter Start" })
		keymap("n", "<leader>fq", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
		keymap("n", "<leader>fr", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
		keymap("n", "<leader>fR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
	end
}
