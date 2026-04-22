vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { noremap = true, silent = true, buffer = bufnr }
		local keymap = vim.keymap.set

		keymap('n', 'gd', vim.lsp.buf.definition, opts)
		keymap('n', '<leader>rf', require('telescope.builtin').lsp_references, opts)
		keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
		keymap('n', '<leader>gr', vim.lsp.buf.references, opts)
		keymap('n', '<leader>gi', vim.lsp.buf.implementation, opts)
		keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		keymap('n', '<C-p>', vim.diagnostic.goto_prev, opts)
		keymap('n', '<C-n>', vim.diagnostic.goto_next, opts)
		keymap('n', 'K', vim.lsp.buf.hover, opts)
	end,
})

return {
	setup = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"jedi_language_server",
				"superhtml",
				"ruff",
			},
		})

		vim.lsp.enable("jedi_language_server")
		vim.lsp.enable("superhtml")

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--header-insertion=never", "--background-index" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
		})
		vim.lsp.enable("clangd")

		vim.lsp.config("lua_ls", {
			settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("ruff", {
			on_attach = function(client, bufnr)
				client.server_capabilities.hoverProvider = false
			end,
		})
		vim.lsp.enable("ruff")

		vim.lsp.enable("denols")
	end
}
