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
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',   
            'hrsh7th/cmp-path',      
            'L3MON4D3/LuaSnip',       
            'saadparwaiz1/cmp_luasnip' 
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
        
            cmp.setup {
            snippet = {
                expand = function(args)
                luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        }
    end
    }

    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    }

    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = { 
                    'omnisharp'
                }
            }
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.omnisharp.setup {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                cmd = { vim.fn.stdpath('data') .. '/mason/packages/omnisharp/omnisharp' },
                on_attach = function(client, bufnr)
                    local bufopts = { noremap=true, silent=true, buffer=bufnr }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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
            require('project_nvim').setup {
                detection_methods = { 'lsp', 'pattern' },
                patterns = { '.sln', '.csproj', '.git', 'makefile' },
            }
            require('telescope').load_extension('projects')

            vim.keymap.set('n', '<leader>fp', require('telescope').extensions.projects.projects)
        end
    }
end)
