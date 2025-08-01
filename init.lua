vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.signcolumn = "yes"
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

vim.keymap.set('n', '<leader>pv', ':Ex<cr>')

vim.keymap.set('n', '<leader>j', ':split<cr>')
vim.keymap.set('n', '<leader>l', ':vsplit<cr>')

vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

vim.cmd [[packadd packer.nvim]]

vim.cmd("colorscheme onedark")

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use "olimorris/onedarkpro.nvim"

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('telescope').setup {
                defaults = {
                    layout_strategy = 'horizontal',
                    layout_config = { prompt_position = "top" },
                    sorting_strategy = "ascending",
                    winblend = 0,
                }
            }

            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
        end
    }

    use {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    }

    use {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "omnisharp" }
            }
        end
    }

    use {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.omnisharp.setup {
                cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp" },
                on_attach = function(client, bufnr)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
                    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover)
                    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signarture_help)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
                    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action)
                    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format()
                    end, bufopts)
                end
            }
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require("project_nvim").setup {
                detection_methods = { "lsp", "pattern" },
                patterns = { ".sln", ".csproj", ".git", "makefile" },
            }
            require('telescope').load_extension('projects')

            vim.keymap.set('n', '<leader>fp', require('telescope').extensions.projects.projects)
        end
    }
end)
