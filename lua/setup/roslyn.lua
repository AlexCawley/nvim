-- Cross-platform Roslyn language server setup
-- This script handles installation on both Windows and Linux

local M = {}

local function is_windows()
    return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function get_roslyn_dir()
    if is_windows() then
        return vim.fn.expand('$LOCALAPPDATA/nvim/roslyn-ls')
    else
        return vim.fn.expand('~/.local/share/nvim/roslyn-ls')
    end
end

local function get_dotnet_command()
    if is_windows() then
        return 'dotnet'
    else
        return 'dotnet'
    end
end

local function check_dotnet()
    local dotnet_cmd = get_dotnet_command()
    local handle = io.popen(dotnet_cmd .. ' --version 2>&1')
    if handle then
        local result = handle:read('*a')
        handle:close()
        if result and result ~= '' and not result:match('not found') then
            return true, result:gsub('%s+', '')
        end
    end
    return false, nil
end

local function download_file(url, output_path)
    local curl_cmd
    if is_windows() then
        curl_cmd = string.format('curl -L -o "%s" "%s"', output_path, url)
    else
        curl_cmd = string.format('curl -L -o "%s" "%s"', output_path, url)
    end

    local handle = io.popen(curl_cmd)
    if handle then
        local result = handle:read('*a')
        handle:close()
        return vim.fn.filereadable(output_path) == 1
    end
    return false
end

local function extract_zip(zip_path, extract_dir)
    local unzip_cmd
    if is_windows() then
        -- Use PowerShell to extract
        unzip_cmd = string.format('powershell -Command "Expand-Archive -Path \'%s\' -DestinationPath \'%s\' -Force"', zip_path, extract_dir)
    else
        unzip_cmd = string.format('unzip -o "%s" -d "%s"', zip_path, extract_dir)
    end

    local handle = io.popen(unzip_cmd)
    if handle then
        local result = handle:read('*a')
        handle:close()
        return true
    end
    return false
end

function M.setup()
    print('Setting up Roslyn language server...')

    -- Check if .NET SDK is installed
    local has_dotnet, dotnet_version = check_dotnet()
    if not has_dotnet then
        vim.notify('.NET SDK not found. Please install .NET SDK from https://dotnet.microsoft.com/download', vim.log.levels.ERROR)
        return false
    end

    print('Found .NET SDK: ' .. dotnet_version)

    -- Create roslyn directory
    local roslyn_dir = get_roslyn_dir()
    if vim.fn.isdirectory(roslyn_dir) == 0 then
        vim.fn.mkdir(roslyn_dir, 'p')
        print('Created directory: ' .. roslyn_dir)
    end

    -- Download Roslyn language server
    local nuget_url = 'https://api.nuget.org/v3-flatcontainer/microsoft.codeanalysis.languageserver/4.8.0-4.24330.1/microsoft.codeanalysis.languageserver.4.8.0-4.24330.1.nupkg'
    local nuget_file = roslyn_dir .. '/roslyn.nupkg'

    print('Downloading Roslyn language server...')
    if not download_file(nuget_url, nuget_file) then
        vim.notify('Failed to download Roslyn language server', vim.log.levels.ERROR)
        return false
    end

    print('Downloaded Roslyn language server')

    -- Extract the package
    print('Extracting Roslyn language server...')
    local zip_file = roslyn_dir .. '/roslyn.zip'
    vim.fn.rename(nuget_file, zip_file)

    if not extract_zip(zip_file, roslyn_dir) then
        vim.notify('Failed to extract Roslyn language server', vim.log.levels.ERROR)
        return false
    end

    -- Clean up
    vim.fn.delete(zip_file)

    -- Find the extracted directory
    local extracted_dirs = vim.fn.glob(roslyn_dir .. '/microsoft.codeanalysis.languageserver*', false, true)
    if #extracted_dirs > 0 then
        local dll_path = extracted_dirs[1] .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
        if vim.fn.filereadable(dll_path) == 1 then
            print('Roslyn language server installed successfully!')
            print('DLL path: ' .. dll_path)
            print('')
            print('Next steps:')
            print('1. Restart Neovim')
            print('2. Open a C# project')
            print('3. Run :Roslyn start to start the language server')
            print('4. Check :Roslyn target if you have multiple solutions')
            return true
        end
    end

    vim.notify('Roslyn language server DLL not found at expected location', vim.log.levels.ERROR)
    return false
end

function M.check_installation()
    local roslyn_dir = get_roslyn_dir()
    local extracted_dirs = vim.fn.glob(roslyn_dir .. '/microsoft.codeanalysis.languageserver*', false, true)

    if #extracted_dirs > 0 then
        local dll_path = extracted_dirs[1] .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
        return vim.fn.filereadable(dll_path) == 1, dll_path
    end

    return false, nil
end

function M.get_server_path()
    local is_installed, dll_path = M.check_installation()
    if is_installed then
        return dll_path
    end
    return nil
end

return M
