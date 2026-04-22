return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fc",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			default_format_opts = {
				timeout_ms = 5000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				python = { "isort", "black" },
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				css = { "biome" },
				html = { "djlint" },
				json = { "jq" },
				yaml = { "yamlfmt" },
				dart = { "dart_format" }
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		})
	end,
}
