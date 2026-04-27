local M = {}

local function bind(op, out_opts) -- thanks to ThePrimeagen
	out_opts = out_opts or { noremap = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force",
			out_opts,
			opts or {}
		)
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

M.bind = bind
M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

function M.toggle_substitute_help()
	local buf = vim.api.nvim_create_buf(false, true)
	local content = {
		"  FIND AND REPLACE REFERENCE  ",
		"  ==========================  ",
		"  Syntax: :[range]s/[find]/[replace]/[flags]",
		"  ",
		"  [RANGES]",
		"  %          Entire file",
		"  .          Current line",
		"  .,$        Cursor to end of file",
		"  1,10       Lines 1 through 10",
		"  '<,'>      Visual selection",
		"  ",
		"  [FLAGS]",
		"  g          Global (all matches on line)",
		"  c          Confirm (ask before replacing)",
		"  i          Ignore case",
		"  I          Strict case",
		"  ",
		"  [TIPS]",
		"  - Use # or + as delimiters for paths: :s#a/b#c/d#",
		"  - Leave [find] empty to use your last / search",
		"  - Use \\<word\\> for exact word matching",
		"  ",
		"  Press q or <Esc> to close this window"
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = 60,
		height = 22,
		col = math.floor((vim.o.columns - 60) / 2),
		row = math.floor((vim.o.lines - 22) / 2),
		style = 'minimal',
		border = 'rounded'
	})

	vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
	vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf })
end

return M
