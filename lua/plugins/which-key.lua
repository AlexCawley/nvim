return function()
    local wk = require('which-key')

    wk.setup()

    -- Register key mappings
    wk.register({
        ["<leader>"] = {
            f = {
                name = "Find",
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
                b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
            },
            e = { "<cmd>NvimTreeFocus<cr>", "Focus File Tree" },
            j = { "<cmd>split<cr>", "Split Horizontal" },
            l = { "<cmd>vsplit<cr>", "Split Vertical" },
        },
        g = {
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to Declaration" },
            r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Go to References" },
        },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Information" },
        ["<C-h>"] = { "<C-w>h", "Go to Left Window" },
        ["<C-j>"] = { "<C-w>j", "Go to Bottom Window" },
        ["<C-k>"] = { "<C-w>k", "Go to Top Window" },
        ["<C-l>"] = { "<C-w>l", "Go to Right Window" },
        ["<C-n>"] = { "<cmd>NvimTreeToggle<cr>", "Toggle File Tree" },
    })
end
