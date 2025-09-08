-- Setup utilities for cross-platform development
-- This module provides setup functions for various language servers

local M = {}

-- Setup commands
function M.setup_commands()
    vim.api.nvim_create_user_command('SetupRoslyn', function()
        local roslyn = require('setup.roslyn')
        roslyn.setup()
    end, { desc = 'Setup Roslyn language server for C# development' })

    vim.api.nvim_create_user_command('CheckRoslyn', function()
        local roslyn = require('setup.roslyn')
        local is_installed, dll_path = roslyn.check_installation()
        if is_installed then
            print('Roslyn language server is installed at: ' .. dll_path)
        else
            print('Roslyn language server is not installed. Run :SetupRoslyn to install it.')
        end
    end, { desc = 'Check if Roslyn language server is installed' })
end

-- Initialize setup commands
M.setup_commands()

return M
