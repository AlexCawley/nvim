return function()
    require('nvim-tree').setup {
        view = {
            width = 60
        }
    }

    -- Nvim-tree key mappings
    vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>')
end
