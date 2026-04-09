return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	init = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	config = function()
		local ufo = require("ufo")

		-- more keybinds here: https://neovim.io/doc/user/fold/

		vim.keymap.set("n", "zO", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zC", ufo.closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor" })
		vim.keymap.set("n", "zc", "zc", { desc = "Close one fold under cursor" })
		vim.keymap.set("n", "zo", "zo", { desc = "Open one fold under cursor" })
		vim.keymap.set("n", "zZ", function() -- doesn't work with za
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold" })

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width can be less than expected and close to zero
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		})
	end,
}
