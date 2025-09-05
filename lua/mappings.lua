require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>j", ":split<CR>")
map("n", "<leader>l", ":vsplit<CR>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
