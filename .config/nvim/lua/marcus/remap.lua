vim.g.mapleader = " "

-- Mapper
local Remap = require("marcus.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

vnoremap('<leader>y', '"+y', { desc = "Yank selection to clipboard" })
nnoremap('<leader>y', '"+y', { desc = "Yank line to clipboard" })
nmap('<leader>Y', 'gg"+yG', { desc = "Yank entire buffer to clipboard" })

vnoremap('<leader>p', '"+P', { desc = "Paste from clipboard (before)" })
nnoremap('<leader>p', '"+P', { desc = "Paste from clipboard (before)" })
xnoremap('<leader>p', '"_dP', { desc = "Paste and keep register" })
