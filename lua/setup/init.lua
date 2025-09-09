-- Setup utilities and commands
-- Cross-platform installation and setup functions

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

-- Install formatters that are not available via Mason
function M.install_external_formatters()
    local os = get_os()

    vim.notify("Installing external formatters for " .. os .. "...", vim.log.levels.INFO)

    if os == "windows" then
        -- Windows installation using chocolatey and npm
        vim.notify("Installing astyle via chocolatey...", vim.log.levels.INFO)
        if command_exists "choco" then
            vim.fn.system "choco install astyle -y"
        else
            vim.notify(
                "Chocolatey not found. Please install chocolatey first or install astyle manually",
                vim.log.levels.WARN
            )
        end

        vim.notify("Installing stylelint via npm...", vim.log.levels.INFO)
        if command_exists "npm" then
            vim.fn.system "npm install -g stylelint"
        else
            vim.notify("npm not found. Please install Node.js first", vim.log.levels.WARN)
        end
    elseif os == "linux" then
        -- Linux installation using apt and npm
        vim.notify("Installing astyle via apt...", vim.log.levels.INFO)
        if command_exists "apt" then
            vim.fn.system "sudo apt update && sudo apt install -y astyle"
        else
            vim.notify("apt not found. Please install astyle manually for your distribution", vim.log.levels.WARN)
        end

        vim.notify("Installing stylelint via npm...", vim.log.levels.INFO)
        if command_exists "npm" then
            vim.fn.system "npm install -g stylelint"
        else
            vim.notify("npm not found. Please install Node.js first", vim.log.levels.WARN)
        end
    elseif os == "macos" then
        -- macOS installation using homebrew and npm
        vim.notify("Installing astyle via homebrew...", vim.log.levels.INFO)
        if command_exists "brew" then
            vim.fn.system "brew install astyle"
        else
            vim.notify(
                "Homebrew not found. Please install homebrew first or install astyle manually",
                vim.log.levels.WARN
            )
        end

        vim.notify("Installing stylelint via npm...", vim.log.levels.INFO)
        if command_exists "npm" then
            vim.fn.system "npm install -g stylelint"
        else
            vim.notify("npm not found. Please install Node.js first", vim.log.levels.WARN)
        end
    end

    vim.notify("External formatter installation complete!", vim.log.levels.INFO)
    vim.notify(
        "Note: Mason-installed formatters (stylua, fixjson, codespell) are handled automatically",
        vim.log.levels.INFO
    )
end

-- Install ripgrep for telescope
function M.install_ripgrep()
    local os = get_os()

    vim.notify("Installing ripgrep for " .. os .. "...", vim.log.levels.INFO)

    if os == "windows" then
        -- Windows installation using chocolatey
        vim.notify("Installing ripgrep via chocolatey...", vim.log.levels.INFO)
        if command_exists "choco" then
            vim.fn.system "choco install ripgrep -y"
        else
            vim.notify(
                "Chocolatey not found. Please install chocolatey first or install ripgrep manually",
                vim.log.levels.WARN
            )
        end
    elseif os == "linux" then
        -- Linux installation using apt
        vim.notify("Installing ripgrep via apt...", vim.log.levels.INFO)
        if command_exists "apt" then
            vim.fn.system "sudo apt update && sudo apt install -y ripgrep"
        else
            vim.notify("apt not found. Please install ripgrep manually for your distribution", vim.log.levels.WARN)
        end
    elseif os == "macos" then
        -- macOS installation using homebrew
        vim.notify("Installing ripgrep via homebrew...", vim.log.levels.INFO)
        if command_exists "brew" then
            vim.fn.system "brew install ripgrep"
        else
            vim.notify(
                "Homebrew not found. Please install homebrew first or install ripgrep manually",
                vim.log.levels.WARN
            )
        end
    end

    vim.notify("Ripgrep installation complete!", vim.log.levels.INFO)
    vim.notify("Ripgrep is now available for telescope live_grep functionality", vim.log.levels.INFO)
end

-- Create user commands
vim.api.nvim_create_user_command("InstallFormatters", M.install_external_formatters, {
    desc = "Install external formatters not available via Mason",
})

vim.api.nvim_create_user_command("InstallRipgrep", M.install_ripgrep, {
    desc = "Install ripgrep for telescope functionality",
})

return M

