return function()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'html',
            'cssls',
            'jsonls',
        },

        automatic_installation = true,
    })
end
