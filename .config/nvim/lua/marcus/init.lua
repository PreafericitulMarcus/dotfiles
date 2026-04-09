vim.opt.termguicolors = true

require("marcus.remap")
require("marcus.lazy_init")
require("marcus.code-runner")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.wo.number = true
vim.opt.scrolloff = 8
vim.opt.sidescroll = 8
vim.opt.sidescrolloff = 8

vim.g.python3_host_prog = "~/.config/nvim/pyenv/bin/python"
