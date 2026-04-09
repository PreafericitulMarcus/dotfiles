vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
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
		local lspconfig = require("lspconfig")

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"sqls",
				"clangd",
				"java_language_server",
				"typescript-language-server",
				"vimls",
				"bashls",
				"pyright",
				"cssls",
				"tailwindcss",
				"html",
				"lua_ls",
				"emmet_ls",
			},
		})

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup_handlers {
			function(server_name)
				lspconfig[server_name].setup()
			end,
			["tsserver"] = function()
				lspconfig.tsserver.setup({
					root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
				})
			end,
			["sqls"] = function()
				lspconfig.sqls.setup({
					on_attach = function(client, bufnr)
						require('sqls').on_attach(client, bufnr)
					end,
					settings = {
						sqls = {
							connections = {
								{
									driver = 'mssql',
									dataSourceName =
									'sqlserver://sa:StrongPassword123%23@localhost:1433?database=EF_WebApiDB&connection+timeout=30'
								},
							},
						},
					},
				})
			end,
			["clangd"] = function()
				local nproc = vim.fn.system('nproc'):gsub("%s+", "")
				lspconfig.clangd.setup({
					cmd = {
						"clangd",
						"--header-insertion=never",
						"-j", nproc,
						"--background-index",
						"--enable-config"
					},
					filetypes = { "c", "cpp", "objc", "objcpp" },
				})
			end,
			["jdtls"] = function()
				local root_dir = require("lspconfig.util").root_pattern("gradlew", "mvnw", ".git")()
				if root_dir then
					require("lspconfig").jdtls.setup {
						cmd = { "jdtls" },
						root_dir = root_dir,
						on_attach = function(client, bufnr)
							require("marcus.lspconfig").on_attach(client, bufnr)
						end,
					}
				end
			end,
			-- ["java_language_server"] = function()
			-- 	lspconfig.java_language_server.setup{
			-- 		cmd = { '/home/marcus/Dev/java-language-server/dist/lang_server_linux.sh'},
			-- 		root_dir = lspconfig.util.root_pattern('.git'),
			-- 	}
			-- end,
			["pyright"] = function()
				lspconfig.pyright.setup({
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
								strict = true,
								typeCheckingMode = "strict",
							},
						},
					},
				})
			end,
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							runtime = {
								version = 'LuaJIT',
								path = (function()
									local runtime_path = vim.split(package.path, ';')
									table.insert(runtime_path, "lua/?.lua")
									table.insert(runtime_path, "lua/?/init.lua")
									return runtime_path
								end)(),
							},
							diagnostics = {
								globals = { 'vim' }
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true)
							}
						}
					}
				})
			end,
			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					filetypes = {
						"html", "css"
					},
				})
			end,
		}
	end
}
