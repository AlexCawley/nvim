return function()
    local wk = require('which-key')

    wk.setup({
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
    })

    wk.add({
        { "<C-h>", "<C-w>h", desc = "Go to Left Window" },
        { "<C-j>", "<C-w>j", desc = "Go to Bottom Window" },
        { "<C-k>", "<C-w>k", desc = "Go to Top Window" },
        { "<C-l>", "<C-w>l", desc = "Go to Right Window" },
        { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
        { "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Focus File Tree" },
        { "<leader>f", group = "Find" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>g", group = "Git" },
        { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
        { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git Pull" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
        { "<leader>gh", group = "Git Hunks" },
        { "<leader>j", "<cmd>split<cr>", desc = "Split Horizontal" },
        { "<leader>l", "<cmd>vsplit<cr>", desc = "Split Vertical" },
        { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Information" },
        { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to Declaration" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
        { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Go to References" },
    })
end
