# Neovim Configuration

This is a modular Neovim configuration organized into logical modules for better maintainability.

## Directory Structure

```
nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   ├── core/               # Core Neovim configuration
│   │   ├── init.lua        # Core configuration loader
│   │   ├── options.lua     # Vim options and settings
│   │   └── keymaps.lua     # Basic key mappings
│   ├── setup/              # Cross-platform setup utilities
│   │   ├── init.lua        # Setup commands and utilities
│   │   └── roslyn.lua      # Roslyn language server setup
│   └── plugins/            # Plugin configurations
│       ├── init.lua        # Plugin manager and main plugin loader
│       ├── telescope.lua   # Telescope fuzzy finder configuration
│       ├── nvim-tree.lua   # File tree configuration
│       ├── mason.lua       # LSP installer configuration
│       ├── lspconfig.lua   # LSP configuration
│       ├── cmp.lua         # Completion configuration
│       ├── which-key.lua   # Key binding help system
│       └── lualine.lua     # Status line configuration
├── setup-roslyn.ps1        # Windows PowerShell Roslyn setup script
├── setup-roslyn.sh         # Linux/macOS shell Roslyn setup script
└── plugin/                 # Packer compiled files (auto-generated)
    └── packer_compiled.lua
```

## Configuration Modules

### Core Configuration (`lua/core/`)

- **`init.lua`**: Loads all core configuration modules
- **`options.lua`**: Contains all vim options, settings, and global variables
- **`keymaps.lua`**: Contains basic key mappings and shortcuts

### Plugin Configuration (`lua/plugins/`)

- **`init.lua`**: Main plugin configuration using packer.nvim
- **`telescope.lua`**: Telescope fuzzy finder setup and key mappings
- **`nvim-tree.lua`**: File tree explorer configuration
- **`mason.lua`**: Mason LSP installer configuration
- **`lspconfig.lua`**: Language Server Protocol configuration
- **`cmp.lua`**: Completion engine configuration
- **`which-key.lua`**: Key binding help system using [which-key.nvim](https://github.com/folke/which-key.nvim)
- **`lualine.lua`**: Status line configuration using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **nvim-web-devicons**: File type icons for enhanced visual elements
- **mini.icons**: Icon library for which-key and other components

## Key Mappings

### File Operations
- `<leader>e`: Focus on file tree
- `<C-n>`: Toggle file tree

### Window Management
- `<leader>j`: Split window horizontally
- `<leader>l`: Split window vertically
- `<C-h/j/k/l>`: Navigate between windows
- `<C-x>`: Exit terminal mode

### Telescope (Fuzzy Finder)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: Find buffers
- `<leader>ma`: Find marks
- `<leader>cm`: Git commits
- `<leader>gt`: Git status
- `<leader>pt`: Find terminals

### LSP (Language Server Protocol)
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Go to references
- `K`: Show hover information
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `<leader>f`: Format code

### C# Development (Roslyn)
- `:Roslyn start`: Start the language server
- `:Roslyn stop`: Stop the language server
- `:Roslyn restart`: Restart the language server
- `:Roslyn target`: Choose solution if multiple exist

### Which-Key Help System
- **Automatic**: Press any key combination to see available mappings
- **Interactive**: Shows key bindings in a popup as you type
- **Organized**: Groups related key mappings together
- **Smart**: Only shows relevant mappings for the current context

### Status Line (Lualine)
- **Mode Indicator**: Shows current Vim mode (Normal, Insert, Visual, etc.)
- **Git Information**: Branch name, diff status, and diagnostics
- **File Information**: Current filename and file type
- **Progress**: Current line and column position
- **Location**: Cursor position in the file
- **Icons**: Beautiful icons for all components using nvim-web-devicons

## Adding New Plugins

To add a new plugin:

1. Add the plugin to `lua/plugins/init.lua`
2. Create a configuration file in `lua/plugins/` if needed
3. Reference the configuration file in the plugin definition
4. Run `:PackerSync` to install the new plugin

Example:
```lua
use {
    'plugin-name/plugin-repo',
    config = require('plugins.plugin-name')
}
```

## Adding New Key Mappings

- **Core mappings**: Add to `lua/core/keymaps.lua`
- **Plugin-specific mappings**: Add to the respective plugin configuration file

## C# Development Setup

This configuration includes support for C# development using the [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) plugin.

### Prerequisites

1. **Install .NET SDK**: Download and install from [dotnet.microsoft.com](https://dotnet.microsoft.com/download)

### Setup Steps

#### Option 1: Automatic Setup (Recommended)
1. **Install plugins**: Restart Neovim and run `:PackerSync`
2. **Setup Roslyn**: Run `:SetupRoslyn` in Neovim
3. **Start Roslyn server**: Open a C# project and run `:Roslyn start`
4. **Select solution** (if multiple): Run `:Roslyn target` to choose the correct solution

#### Option 2: Manual Setup
**Windows:**
```powershell
# Run in PowerShell as Administrator
.\setup-roslyn.ps1
```

**Linux/macOS:**
```bash
# Make script executable and run
chmod +x setup-roslyn.sh
./setup-roslyn.sh
```

#### Option 3: Check Installation
- **Check if installed**: Run `:CheckRoslyn` in Neovim
- **Manual verification**: Check if the language server is properly installed

### Features

- **Code Navigation**: Go to definition, references, declarations
- **IntelliSense**: Auto-completion with C# language features
- **Code Actions**: Quick fixes and refactoring suggestions
- **Inlay Hints**: Type hints and parameter names
- **Code Lens**: References and test indicators
- **Formatting**: Automatic code formatting

### Troubleshooting

- **Server not starting**: Check that .NET SDK is installed and in PATH
- **No completions**: Ensure the language server is running (`:Roslyn start`)
- **Wrong solution**: Use `:Roslyn target` to select the correct solution
- **Performance issues**: Check the [roslyn.nvim documentation](https://github.com/seblyng/roslyn.nvim) for configuration options

## Benefits of This Structure

1. **Modularity**: Each component is in its own file
2. **Maintainability**: Easy to find and modify specific configurations
3. **Scalability**: Easy to add new plugins and configurations
4. **Readability**: Clear separation of concerns
5. **Reusability**: Configuration modules can be easily shared or reused
