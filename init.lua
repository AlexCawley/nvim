vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

vim.keymap.set('n', '<leader>j', ':split<CR>')
vim.keymap.set('n', '<leader>l', ':vsplit<CR>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'olimorris/onedarkpro.nvim',
        config = function()
            vim.cmd('colorscheme onedark')
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_strategy = 'horizontal',
                    layout_config = { prompt_position = 'top' },
                    sorting_strategy = 'ascending',
                    winblend = 0,
                }
            }

            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
            vim.keymap.set("n", "<leader>ma", require('telescope.builtin').marks)
            vim.keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>")
            vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>")
            vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>")
        end
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup {
                view = {
                    width = 60
                }
            }

            vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>")
        end
    }
end)
