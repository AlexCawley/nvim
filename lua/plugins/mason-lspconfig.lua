return function()
    require('mason-lspconfig').setup({
        -- Automatically install these language servers
        ensure_installed = {
            'html',     -- HTML Language Server
            'cssls',    -- CSS Language Server
            'jsonls',   -- JSON Language Server
        },

        -- Automatically install language servers when opening relevant files
        automatic_installation = true,
    })
end
