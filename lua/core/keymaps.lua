-- Window splitting
vim.keymap.set('n', '<leader>j', ':split<CR>')
vim.keymap.set('n', '<leader>l', ':vsplit<CR>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('t', '<C-x>', '<C-\\><C-N>')
