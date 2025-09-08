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

    -- LSP configuration
    use {
        'neovim/nvim-lspconfig',
        config = require('plugins.lspconfig')
    }

    -- Roslyn (C# LSP)
    use 'seblyng/roslyn.nvim'

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

     -- Which-key (key binding help) - temporarily disabled
     use {
         'folke/which-key.nvim',
         config = require('plugins.which-key')
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
end)
