-- Main Neovim configuration
-- This file loads all configuration modules

-- Load core configuration (options and keymaps)
require('core')

-- Load setup utilities
require('setup')

-- Auto-install Packer if not present
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing Packer...')
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd 'packadd packer.nvim'
    print('Packer installed! Please restart Neovim and run :PackerSync to install plugins.')
end

-- Load plugin configuration with error handling
local status_ok, plugins = pcall(require, 'plugins')
if not status_ok then
    vim.notify('Failed to load plugins configuration', vim.log.levels.ERROR)
    return
end
