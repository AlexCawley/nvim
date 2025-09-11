-- Setup utilities for easy-dotnet.nvim
local M = {}

-- Detect operating system
local function get_os()
    if vim.fn.has "win32" == 1 then
        return "windows"
    elseif vim.fn.has "unix" == 1 then
        if vim.fn.system("uname"):match "Darwin" then
            return "macos"
        else
            return "linux"
        end
    end
    return "unknown"
end

-- Check if a command exists
local function command_exists(cmd)
    local handle = io.popen(cmd .. " --version 2>&1")
    if handle then
        local result = handle:read "*a"
        handle:close()
        return result ~= "" and not result:match "not found" and not result:match "is not recognized"
    end
    return false
end

-- Install EasyDotnet and jq for easy-dotnet.nvim plugin
function M.setup_easy_dotnet()
    local os = get_os()

    vim.notify("Setting up EasyDotnet dependencies for " .. os .. "...", vim.log.levels.INFO)

    -- Install EasyDotnet tool globally
    vim.notify("Installing EasyDotnet tool globally...", vim.log.levels.INFO)
    if command_exists "dotnet" then
        vim.fn.system "dotnet tool install -g EasyDotnet"
    else
        vim.notify("dotnet CLI not found. Please install .NET SDK first", vim.log.levels.ERROR)
        return
    end

    -- Install jq based on operating system
    if os == "windows" then
        vim.notify("Installing jq via chocolatey...", vim.log.levels.INFO)
        if command_exists "choco" then
            vim.fn.system "choco install jq -y"
        else
            vim.notify(
                "Chocolatey not found. Please install chocolatey first or install jq manually",
                vim.log.levels.WARN
            )
        end
    elseif os == "linux" then
        vim.notify("Installing jq via apt...", vim.log.levels.INFO)
        if command_exists "apt" then
            vim.fn.system "sudo apt update && sudo apt install -y jq"
        else
            vim.notify("apt not found. Please install jq manually for your distribution", vim.log.levels.WARN)
        end
    elseif os == "macos" then
        vim.notify("Installing jq via homebrew...", vim.log.levels.INFO)
        if command_exists "brew" then
            vim.fn.system "brew install jq"
        else
            vim.notify(
                "Homebrew not found. Please install homebrew first or install jq manually",
                vim.log.levels.WARN
            )
        end
    end

    vim.notify("EasyDotnet setup complete!", vim.log.levels.INFO)
    vim.notify("You can now use the easy-dotnet.nvim plugin", vim.log.levels.INFO)
end

return M