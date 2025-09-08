return function()
    require('gitsigns').setup({
        signs = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },

        -- Sign column options
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,      -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,     -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false,  -- Toggle with `:Gitsigns toggle_word_diff`

        -- Watch git dir for changes
        watch_gitdir = {
            follow_files = true
        },

        -- Hunk options
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
        },

        -- Preview options
        preview_config = {
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },

        -- Keymaps setup - integrate with which-key
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            -- Navigation
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gitsigns.nav_hunk('next')
                end
            end, { buffer = bufnr, desc = 'Next git hunk' })

            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gitsigns.nav_hunk('prev')
                end
            end, { buffer = bufnr, desc = 'Previous git hunk' })

            -- Staging/unstaging
            vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
            vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
            vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = 'Stage hunk' })
            vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = 'Reset hunk' })
            vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
            vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
            vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })

            -- Preview and blame
            vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
            vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { buffer = bufnr, desc = 'Blame line' })
            vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle line blame' })
            vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'Diff this' })
            vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end, { buffer = bufnr, desc = 'Diff this ~' })

            -- Text object
            vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr, desc = 'Select hunk' })
        end
    })
end
