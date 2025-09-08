return function()
    require("mason-tool-installer").setup {
        ensure_installed = {
            -- Formatters
            "stylua", -- Lua formatter
            "fixjson", -- JSON formatter
            "codespell", -- Spelling checker
        },

        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
    }
end

