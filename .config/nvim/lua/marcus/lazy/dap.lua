return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	event = "VeryLazy",
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

		dap.adapters.python = {
			type = "executable",
			command = "/home/marcus/.virtualenvs/debugpy/bin/python3",
			args = { "-m", "debugpy.adapter" },
		}

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return vim.fn.exepath("python3") or "/usr/bin/python3"
					end
				end,
			},
		}

		local gdb_config = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}
		dap.configurations.c = gdb_config
		dap.configurations.cpp = gdb_config

		vim.keymap.set("n", "<F8>", dap.continue, { desc = "DAP: Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
		vim.keymap.set("n", "<Leader>bp", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })

		vim.keymap.set("n", "<Leader>B", function()
			dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end, { desc = "DAP: Conditional breakpoint" })
	end,
}
