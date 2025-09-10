return function()
    local lspconfig = require "lspconfig"
    local cmp_nvim_lsp = require "cmp_nvim_lsp"
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Configure diagnostics display
    vim.diagnostic.config {
        virtual_text = {
            enabled = true,
            source = "if_many",
            prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    -- Configure diagnostic signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local on_attach = function(client, bufnr)
        -- Enable inlay hints
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

        -- Key mappings for diagnostics
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next, opts)
        
        -- Code actions (like auto-import suggestions)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    -- Setup Roslyn for C# development using Mason
    require("roslyn").setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_parameters = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
            },
            ["csharp|completion"] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
                dotnet_provide_regex_completions = true,
            },
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
                dotnet_enable_tests_code_lens = true,
            },
            ["csharp|formatting"] = {
                dotnet_organize_imports_on_format = true,
            },
        },
    }

    -- HTML Language Server
    lspconfig.html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "cshtml", "razor" },
    }

    -- CSS Language Server
    lspconfig.cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    -- JSON Language Server
    lspconfig.jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    }

    -- Lua Language Server
    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }

    -- Terraform Language Server
    lspconfig.terraformls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "terraform", "terraform-vars" },
    }
end
