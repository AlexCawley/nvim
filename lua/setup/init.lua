-- Setup utilities and commands
-- Cross-platform installation and setup functions

local M = {}

-- Load setup modules
local formatters = require('setup.formatters')
local ripgrep = require('setup.ripgrep')
local easy_dotnet = require('setup.easy-dotnet')
local debugger = require('setup.debugger')

-- Setup complete development environment
function M.setup_dev_env()
    vim.notify("Setting up complete development environment...", vim.log.levels.INFO)
    vim.notify("This will install formatters, ripgrep, .NET tools, and C# debugger", vim.log.levels.INFO)

    -- Run all setup functions
    formatters.install_external_formatters()
    ripgrep.install_ripgrep()
    easy_dotnet.setup_easy_dotnet()

    vim.notify("Development environment setup complete!", vim.log.levels.INFO)
    vim.notify("All tools have been installed and configured", vim.log.levels.INFO)
end

-- Create user commands
vim.api.nvim_create_user_command("InstallFormatters", formatters.install_external_formatters, {
    desc = "Install external formatters not available via Mason",
})

vim.api.nvim_create_user_command("InstallRipgrep", ripgrep.install_ripgrep, {
    desc = "Install ripgrep for telescope functionality",
})

vim.api.nvim_create_user_command("SetupEasyDotnet", easy_dotnet.setup_easy_dotnet, {
    desc = "Install EasyDotnet tool and jq for easy-dotnet.nvim plugin",
})


vim.api.nvim_create_user_command("SetupDevEnv", M.setup_dev_env, {
    desc = "Setup complete development environment (runs all setup commands)",
})

return M
