return function()
    require('telescope').setup {
        defaults = {
            layout_strategy = 'horizontal',
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
            winblend = 0,
        }
    }

    -- Telescope key mappings
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>ma', require('telescope.builtin').marks)
    vim.keymap.set('n', '<leader>cm', '<cmd>Telescope git_commits<CR>')
    vim.keymap.set('n', '<leader>gt', '<cmd>Telescope git_status<CR>')
    vim.keymap.set('n', '<leader>pt', '<cmd>Telescope terms<CR>')
end
