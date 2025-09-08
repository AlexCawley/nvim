# PowerShell script to set up Roslyn language server for Neovim
# Run this script as Administrator if needed

Write-Host "Setting up Roslyn language server for Neovim..." -ForegroundColor Green

# Check if .NET SDK is installed
Write-Host "Checking for .NET SDK..." -ForegroundColor Yellow
try {
    $dotnetVersion = dotnet --version
    Write-Host ".NET SDK found: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host ".NET SDK not found. Please install .NET SDK from https://dotnet.microsoft.com/download" -ForegroundColor Red
    exit 1
}

# Create directory for Roslyn language server
$roslynDir = "$env:LOCALAPPDATA\nvim\roslyn-ls"
if (!(Test-Path $roslynDir)) {
    New-Item -ItemType Directory -Path $roslynDir -Force
    Write-Host "Created directory: $roslynDir" -ForegroundColor Green
}

# Download and extract Roslyn language server
Write-Host "Downloading Roslyn language server..." -ForegroundColor Yellow
$nugetUrl = "https://api.nuget.org/v3-flatcontainer/microsoft.codeanalysis.languageserver/4.8.0-4.24330.1/microsoft.codeanalysis.languageserver.4.8.0-4.24330.1.nupkg"
$nugetFile = "$roslynDir\roslyn.nupkg"

try {
    Invoke-WebRequest -Uri $nugetUrl -OutFile $nugetFile
    Write-Host "Downloaded Roslyn language server" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Roslyn language server: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Extract the package
Write-Host "Extracting Roslyn language server..." -ForegroundColor Yellow
try {
    # Rename .nupkg to .zip and extract
    $zipFile = "$roslynDir\roslyn.zip"
    Copy-Item $nugetFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $roslynDir -Force
    Remove-Item $zipFile
    Remove-Item $nugetFile
    Write-Host "Extracted Roslyn language server" -ForegroundColor Green
} catch {
    Write-Host "Failed to extract Roslyn language server: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Find the extracted directory
$extractedDir = Get-ChildItem -Path $roslynDir -Directory | Where-Object { $_.Name -like "microsoft.codeanalysis.languageserver*" } | Select-Object -First 1
if ($extractedDir) {
    $dllPath = Join-Path $extractedDir.FullName "Microsoft.CodeAnalysis.LanguageServer.dll"
    if (Test-Path $dllPath) {
        Write-Host "Roslyn language server installed successfully!" -ForegroundColor Green
        Write-Host "DLL path: $dllPath" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Yellow
        Write-Host "1. Restart Neovim" -ForegroundColor White
        Write-Host "2. Open a C# project" -ForegroundColor White
        Write-Host "3. Run :Roslyn start to start the language server" -ForegroundColor White
        Write-Host "4. Check :Roslyn target if you have multiple solutions" -ForegroundColor White
    } else {
        Write-Host "Roslyn language server DLL not found at expected location" -ForegroundColor Red
    }
} else {
    Write-Host "Could not find extracted Roslyn directory" -ForegroundColor Red
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
