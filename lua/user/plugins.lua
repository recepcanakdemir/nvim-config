local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "rafi/awesome-vim-colorschemes"
  use "tpope/vim-surround" --Surrounding ysw
  use "preservim/nerdtree" --NerdTre
  use "tpope/vim-commentary" --For Commenting gcc & gc
  use "vim-airline/vim-airline" --Status bar
  use "lifepillar/pgsql.vim" --PSQL Pluging needs :SQLSetType pgsql.vim
  use "ap/vim-css-color"  --CSS Color Preview
  use "rafi/awesome-vim-colorschemes" --Retro Scheme
  use "tc50cal/vim-terminal" --Vim Terminal
  use "preservim/tagbar" --Tagbar for code navigation
  use "terryma/vim-multiple-cursors" -- CTRL + N for multiple cursors
  use "folke/tokyonight.nvim"
  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  --use "lunarvim/darkplus.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
