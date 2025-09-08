#!/bin/bash
# Cross-platform setup script for Roslyn language server
# This script works on both Linux and macOS

set -e

echo "Setting up Roslyn language server for Neovim..."

# Check if .NET SDK is installed
echo "Checking for .NET SDK..."
if ! command -v dotnet &> /dev/null; then
    echo "❌ .NET SDK not found. Please install .NET SDK from https://dotnet.microsoft.com/download"
    exit 1
fi

DOTNET_VERSION=$(dotnet --version)
echo "✅ .NET SDK found: $DOTNET_VERSION"

# Create directory for Roslyn language server
ROSLYN_DIR="$HOME/.local/share/nvim/roslyn-ls"
mkdir -p "$ROSLYN_DIR"
echo "📁 Created directory: $ROSLYN_DIR"

# Download and extract Roslyn language server
echo "📥 Downloading Roslyn language server..."
NUGET_URL="https://api.nuget.org/v3-flatcontainer/microsoft.codeanalysis.languageserver/4.8.0-4.24330.1/microsoft.codeanalysis.languageserver.4.8.0-4.24330.1.nupkg"
NUGET_FILE="$ROSLYN_DIR/roslyn.nupkg"

if ! curl -L -o "$NUGET_FILE" "$NUGET_URL"; then
    echo "❌ Failed to download Roslyn language server"
    exit 1
fi

echo "✅ Downloaded Roslyn language server"

# Extract the package
echo "📦 Extracting Roslyn language server..."
ZIP_FILE="$ROSLYN_DIR/roslyn.zip"
mv "$NUGET_FILE" "$ZIP_FILE"

if ! unzip -o "$ZIP_FILE" -d "$ROSLYN_DIR"; then
    echo "❌ Failed to extract Roslyn language server"
    exit 1
fi

# Clean up
rm "$ZIP_FILE"

# Find the extracted directory
EXTRACTED_DIR=$(find "$ROSLYN_DIR" -name "microsoft.codeanalysis.languageserver*" -type d | head -1)
if [ -n "$EXTRACTED_DIR" ]; then
    DLL_PATH="$EXTRACTED_DIR/Microsoft.CodeAnalysis.LanguageServer.dll"
    if [ -f "$DLL_PATH" ]; then
        echo "✅ Roslyn language server installed successfully!"
        echo "📄 DLL path: $DLL_PATH"
        echo ""
        echo "Next steps:"
        echo "1. Restart Neovim"
        echo "2. Open a C# project"
        echo "3. Run :Roslyn start to start the language server"
        echo "4. Check :Roslyn target if you have multiple solutions"
    else
        echo "❌ Roslyn language server DLL not found at expected location"
        exit 1
    fi
else
    echo "❌ Could not find extracted Roslyn directory"
    exit 1
fi

echo ""
echo "🎉 Setup complete!"
