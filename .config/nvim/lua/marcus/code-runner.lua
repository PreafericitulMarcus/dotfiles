local function run_code(arguments)
	vim.cmd("w")

	local commands = {
		python = "python3 %",
		dart = "dart run %",
	}

	local ft = vim.bo.filetype
	local cmd = commands[ft]

	if cmd then
		if arguments then
			local args = vim.fn.input("Args: ")
			if args ~= "" then
				cmd = cmd .. " " .. args
			end
		end
		vim.cmd("belowright split | terminal " .. cmd)
		vim.cmd("startinsert")
	else
		print("No runner for filetype " .. ft)
	end
end

vim.keymap.set("n", "<F5>", function() run_code(false) end)

vim.keymap.set("n", "<Leader><F5>", function() run_code(true) end)
