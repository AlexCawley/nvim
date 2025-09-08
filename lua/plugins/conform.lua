return function()
    local conform = require "conform"

    conform.setup {
        formatters_by_ft = {
            cs = { "astyle" },
            json = { "fixjson" },
            css = { "stylelint" },
            -- Apply codespell and trim_whitespace to all file types
            ["*"] = { "codespell", "trim_whitespace" },
        },

        formatters = {
            astyle = {
                prepend_args = { "--style=allman", "--indent=spaces=4" },
            },
            stylelint = {
                args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
            },
        },

        -- Format on save (optional, can be enabled/disabled as needed)
        format_on_save = false,

        -- Timeout for formatters
        timeout_ms = 500,

        -- Log level for conform
        log_level = vim.log.levels.ERROR,
    }

    -- Keymaps for formatting
    vim.keymap.set("n", "<leader>fm", function()
        require("conform").format { lsp_fallback = true }
    end, { desc = "Format current file" })

    vim.keymap.set("v", "<leader>fm", function()
        require("conform").format { lsp_fallback = true }
    end, { desc = "Format selection" })
end
