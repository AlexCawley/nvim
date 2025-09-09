return function()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'html',
            'cssls',
            'jsonls',
            'lua_ls',
            'terraformls',
        },

        automatic_installation = true,
    })
end
