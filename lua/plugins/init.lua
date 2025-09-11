vim.cmd [[packadd packer.nvim]]

-- Check if Packer is available
local packer_available, packer = pcall(require, 'packer')
if not packer_available then
    vim.notify('Packer not available, please restart Neovim', vim.log.levels.ERROR)
    return
end

return packer.startup(function(use)
    -- Plugin manager
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use {
        'olimorris/onedarkpro.nvim',
        config = function()
            vim.cmd('colorscheme onedark')
        end
    }

    -- Treesitter (syntax highlighting and parsing)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "json", "html", "css", "javascript", "typescript", "c_sharp", "terraform" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    }

    -- Telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = require('plugins.telescope')
    }

    -- File tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = require('plugins.nvim-tree')
    }

    -- Mason (LSP installer)
    use {
        'mason-org/mason.nvim',
        config = require('plugins.mason')
    }

    -- Mason-lspconfig bridge for automatic server installation
    use {
        'williamboman/mason-lspconfig.nvim',
        after = 'mason.nvim',
        config = require('plugins.mason-lspconfig')
    }

    -- Mason tool installer for formatters and linters
    use {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        after = 'mason.nvim',
        config = require('plugins.mason-tool-installer')
    }

    -- LSP configuration
    use {
        'neovim/nvim-lspconfig',
        config = require('plugins.lspconfig')
    }

    -- Roslyn (C# LSP)
    use 'seblyng/roslyn.nvim'

    -- JSON schemas for better JSON support
    use 'b0o/schemastore.nvim'

    -- Completion engine
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = require('plugins.cmp')
    }

    -- Which-key (key binding help)
    use {
        'folke/which-key.nvim',
        config = require('plugins.which-key')
    }

    -- Git integration
    use 'tpope/vim-fugitive'

    use {
        'lewis6991/gitsigns.nvim',
        config = require('plugins.gitsigns')
    }

    -- Lualine (status line)
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = require('plugins.lualine')
    }

    -- Devicons (for file type icons)
    use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({
                -- Enable default icons
                default = true,
            })
        end
    }

    -- Mini.icons (for which-key icons)
    use {
        'echasnovski/mini.icons',
        config = function()
            require('mini.icons').setup()
        end
    }

    -- Bufferline tabs
    use {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = require('plugins.bufferline')
    }

    -- Conform (formatting)
    use {
        'stevearc/conform.nvim',
        config = require('plugins.conform')
    }

    -- Easy .NET development
    use {
        'GustavEikaas/easy-dotnet.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
        config = require('plugins.easy-dotnet')
    }
end)
