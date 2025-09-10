# Neovim Configuration

This is a modular Neovim configuration organized into logical modules for better maintainability.

## Directory Structure

```
nvim/
├── init.lua                     # Main configuration entry point
├── lua/
│   ├── core/                   # Core Neovim configuration
│   │   ├── init.lua            # Core configuration loader
│   │   ├── options.lua         # Vim options and settings
│   │   └── keymaps.lua         # Basic key mappings
│   ├── setup/                  # Cross-platform setup utilities
│   │   └── init.lua            # Setup commands and utilities
│   └── plugins/                # Plugin configurations
│       ├── init.lua            # Plugin manager and main plugin loader
│       ├── telescope.lua       # Telescope fuzzy finder configuration
│       ├── nvim-tree.lua       # File tree configuration
│       ├── mason.lua           # LSP installer configuration
│       ├── mason-lspconfig.lua # Automatic LSP server installation
│       ├── lspconfig.lua       # LSP configuration
│       ├── cmp.lua             # Completion configuration
│       ├── which-key.lua       # Key binding help system
│       ├── gitsigns.lua        # Git integration and visual indicators
│       ├── bufferline.lua      # Buffers as tabs setup
│       └── lualine.lua         # Status line configuration
└── plugin/                     # Packer compiled files (auto-generated)
    └── packer_compiled.lua
```

## Configuration Modules

### Core Configuration (`lua/core/`)

- **`init.lua`**: Loads all core configuration modules
- **`options.lua`**: Contains all vim options, settings, and global variables
- **`keymaps.lua`**: Contains basic key mappings and shortcuts

### Setup Utilities (`lua/setup/`)

- **`init.lua`**: Cross-platform installation utilities and setup commands

### Plugin Configuration (`lua/plugins/`)

- **`init.lua`**: Main plugin configuration using packer.nvim
- **`telescope.lua`**: Telescope fuzzy finder setup and key mappings
- **`nvim-tree.lua`**: File tree explorer configuration
- **`mason.lua`**: Mason LSP installer configuration
- **`mason-lspconfig.lua`**: Automatic installation of HTML, CSS, and JSON language servers
- **`mason-tool-installer.lua`**: Automatic installation of formatters and tools
- **`lspconfig.lua`**: Language Server Protocol configuration for C#, HTML, CSS, and JSON
- **`cmp.lua`**: Completion engine configuration
- **`which-key.lua`**: Key binding help system using [which-key.nvim](https://github.com/folke/which-key.nvim)
- **`gitsigns.lua`**: Git integration with visual indicators, staging, and blame
- **`lualine.lua`**: Status line configuration using [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **`nvim-web-devicons`**: File type icons for enhanced visual elements
- **`mini.icons`**: Icon library for which-key and other components
- **`bufferline.lua`**: Buffers as tabs
- **`conform.lua`**: Code formatting using [conform.nvim](https://github.com/stevearc/conform.nvim)

## Key Mappings

### File Operations
- `<leader>ef`: Focus on file tree
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

### Code Formatting (Conform.nvim)
- `<leader>fm`: Format current file or visual selection
- **Supported formatters**:
  - **Lua**: `stylua` (auto-installed via Mason)
  - **C#**: `astyle`
  - **JSON**: `fixjson` (auto-installed via Mason)
  - **CSS**: `stylelint`
  - **All files**: `codespell` (spelling correction, auto-installed) and `trim_whitespace` (cleanup)

### LSP (Language Server Protocol)
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Go to references
- `K`: Show hover information
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions (auto-import, quick fixes, refactoring suggestions)

### LSP Diagnostics
- `<leader>d`: Show line diagnostics in floating window
- `<leader>nd`: Go to next diagnostic
- `<leader>pd`: Go to previous diagnostic

### Git Integration (Fugitive + Gitsigns)
- `<leader>g`: Git menu
- `<leader>gs`: Git status (interactive staging)
- `<leader>gc`: Git commit
- `<leader>gp`: Git push
- `<leader>gl`: Git pull
- `<leader>gb`: Git blame
- `<leader>gd`: Git diff split
- `<leader>gaa`: Git add all (stage all changes)

### Git Hunks (Gitsigns)
- `]c` / `[c`: Navigate to next/previous git hunk
- `<leader>hs`: Stage hunk (normal/visual mode)
- `<leader>hr`: Reset hunk (normal/visual mode)
- `<leader>hS`: Stage entire buffer
- `<leader>hR`: Reset entire buffer
- `<leader>hu`: Undo stage hunk
- `<leader>hp`: Preview hunk
- `<leader>hb`: Blame line (with full info)
- `<leader>hd`: Diff this file
- `<leader>tb`: Toggle line blame
- `ih`: Select hunk (text object)

### C# Development (Roslyn)
- `:Roslyn start`: Start the language server
- `:Roslyn stop`: Stop the language server
- `:Roslyn restart`: Restart the language server
- `:Roslyn target`: Choose solution if multiple exist

### Bufferline
- `<leader>bp`: Jump to a specific buffer with one keystroke
- `<tab>`: Cycle to the next buffer
- `<S-tab>`: Cycle to the previous buffer
- `<leader>x`: Close a buffer (interactive picker)
- `<C-w>`: Close current buffer (keeps window open)

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

## Language Support

This configuration provides comprehensive language server support for modern web and .NET development:

### Supported Languages

#### C# (.cs, .csproj, .sln)
- **Language Server**: Roslyn (via roslyn.nvim)
- **Features**: IntelliSense, code navigation, refactoring, inlay hints, code lens
- **Installation**: Manual via `:SetupRoslyn` command

#### HTML (.html, .cshtml, .razor)
- **Language Server**: HTML Language Server
- **Features**: Auto-completion, syntax validation, tag matching
- **Installation**: Automatic via mason-lspconfig
- **Supports**: Standard HTML, ASP.NET Razor files, and Blazor components

#### CSS (.css, .scss, .sass)
- **Language Server**: CSS Language Server
- **Features**: Property completion, color preview, linting
- **Installation**: Automatic via mason-lspconfig

#### JSON (.json)
- **Language Server**: JSON Language Server with SchemaStore
- **Features**: Schema validation, auto-completion, error detection
- **Installation**: Automatic via mason-lspconfig
- **Enhanced**: Includes schemas for package.json, tsconfig.json, and more

#### HCL/Terraform (.tf, .tfvars)
- **Language Server**: Terraform Language Server
- **Features**: Syntax highlighting, auto-completion, validation, formatting
- **Installation**: Automatic via mason-lspconfig
- **Supports**: Terraform configuration files and variable definitions

### Automatic Installation

The following language servers are automatically installed when you first open the relevant file types:
- `html` - HTML Language Server
- `cssls` - CSS Language Server
- `jsonls` - JSON Language Server
- `terraformls` - Terraform Language Server

## Git Integration

This configuration includes comprehensive Git support through two complementary plugins:

### **Vim-Fugitive** - Complete Git Command Interface
- **Interactive Git Status**: Run `:Git` or `:G` for a full-featured git status buffer
- **Staging Interface**: Stage/unstage files and hunks directly from the status window
- **Complete Git Commands**: Access any git command with `:Git <command>`
- **Diff and Merge**: Advanced diff views and 3-way merge resolution
- **Git History**: Browse commits, branches, and file history

### **Gitsigns** - Visual Git Integration
- **Gutter Signs**: Visual indicators for added, modified, and deleted lines
- **Hunk Operations**: Stage, reset, and navigate individual code changes
- **Live Blame**: See git blame information inline or on-demand
- **Preview Changes**: View diffs without leaving your buffer
- **Stage Selection**: Stage specific lines or visual selections

### Git Workflow Features
- **Real-time Updates**: Git status updates automatically as you work
- **Conflict Resolution**: Visual merge conflict resolution tools
- **Branch Management**: Switch branches, create branches, view git log
- **Staging Granularity**: Stage entire files, hunks, or individual lines
- **Blame Integration**: See who changed what and when, with full commit info

## Formatter Installation

### Automatic Installation (via Mason)

Most formatters are automatically installed via **mason-tool-installer.nvim**:

- **stylua** (Lua formatter)
- **fixjson** (JSON formatter) 
- **codespell** (Spelling checker)

These will be installed automatically when you run `:PackerSync` and restart Neovim.

### Manual Installation Required

Some formatters need manual installation as they're not available in the Mason registry:

#### Option 1: Automatic Installation (Recommended)
Use the built-in Neovim command:
```vim
:InstallFormatters
```

This command will automatically detect your operating system and install:
- **astyle** (C# formatter) via chocolatey/homebrew/apt
- **stylelint** (CSS formatter) via npm

#### Option 2: Manual Installation
```bash
# C# formatting (astyle)
# Windows (via chocolatey):
choco install astyle
# macOS (via homebrew):
brew install astyle
# Linux (Ubuntu/Debian):
sudo apt install astyle

# CSS formatting (stylelint)
npm install -g stylelint
```

**Prerequisites**: Make sure you have the appropriate package managers installed:
- **Windows**: Chocolatey and Node.js/npm
- **macOS**: Homebrew and Node.js/npm  
- **Linux**: apt (Ubuntu/Debian) and Node.js/npm

**Note**: `trim_whitespace` is built into conform.nvim and requires no external installation.

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

### Features

- **Code Navigation**: Go to definition, references, declarations
- **IntelliSense**: Auto-completion with C# language features
- **Code Actions**: Quick fixes and refactoring suggestions
- **Inlay Hints**: Type hints and parameter names
- **Code Lens**: References and test indicators
- **Formatting**: Automatic code formatting
