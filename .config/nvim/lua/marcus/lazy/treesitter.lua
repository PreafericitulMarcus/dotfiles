return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"vim",
				"bash",
				"python",
				"json",
				"markdown",
				"markdown_inline",
				"query",
				"cpp",
				"c",
				"html",
				"css"
			},
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
				},
			},
			autopairs = {
				enable = true,
			},
		})
	end,
}
