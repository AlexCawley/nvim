-- Set leader key
vim.g.mapleader = ' '

-- Basic display options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8

-- Indentation options
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Window splitting options
vim.opt.splitbelow = true
vim.opt.splitright = true

-- File handling options
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false

-- Disable intro screen
vim.opt.shortmess:append("I")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- File type detection for Razor files
vim.filetype.add({
    extension = {
        cshtml = "html",
        razor = "html",
    },
})
