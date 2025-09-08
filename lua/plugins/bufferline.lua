return function()
    vim.opt.termguicolors = true 
    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            mode = "buffers",
            style_preset = {
                bufferline.style_preset.minimal,
                bufferline.style_preset.no_italic,
                bufferline.style_preset.no_bold
            },
            tab_size = 25,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align =  "center" ,
                    separator = true,
                }
            },
        }
    }

    vim.keymap.set('n', '<leader>blp', ':BufferLinePick<CR>')
    vim.keymap.set('n', '<tab>', ':BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<S-tab>', ':BufferLineCyclePrev<CR>')
end
