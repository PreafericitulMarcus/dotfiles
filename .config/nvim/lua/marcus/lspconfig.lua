vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { noremap = true, silent = true, buffer = bufnr }
		local keymap = vim.keymap.set

		keymap('n', 'gd', vim.lsp.buf.definition, opts)
		keymap('n', '<leader>rf', require('telescope.builtin').lsp_references, opts)
		keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
		keymap('n', '<leader>gr', vim.lsp.buf.references, opts)
		keymap('n', '<leader>gi', vim.lsp.buf.implementation, opts)
		keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		keymap('i', '<C-k>', vim.lsp.buf.signature_help, opts)
		keymap('n', '<C-p>', vim.diagnostic.goto_prev, opts)
		keymap('n', '<C-n>', vim.diagnostic.goto_next, opts)
		keymap('n', 'K', vim.lsp.buf.hover, opts)

		if client and client.name == 'ruff' then
			client.server_capabilities.hoverProvider = false
		end
	end,
})

return {
	setup = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"html",
				"ruff",
				"ts_ls",
				"pyright",
			},
		})

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		vim.lsp.config('*', { capabilities = capabilities })

		vim.lsp.enable("pyright")

		local custom_data_path = vim.fn.expand("~/.config/nvim/alpine-html-data.json")
		vim.lsp.config("html", {
			settings = {
				html = {
					customData = { custom_data_path }
				}
			}
		})
		vim.lsp.enable("html")

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

		vim.lsp.enable("ts_ls")
	end
}
