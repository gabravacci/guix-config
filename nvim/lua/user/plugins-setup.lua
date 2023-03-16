local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true for fresh install

-- reload neovim whenever this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function (use)
  use("wbthomason/packer.nvim")

  -- nix support
  use("LnL7/vim-nix")

  -- TeX
  use("lervag/vimtex")

  -- lua plugin dependencies
  use("nvim-lua/plenary.nvim")

  -- colorscheme
  -- use("bluz71/vim-nightfly-guicolors")
  use("folke/tokyonight.nvim")

  -- zen mode
  use("Pocco81/true-zen.nvim")

  -- window management
  use("szw/vim-maximizer") -- maximize and minimize functionality
  use("christoomey/vim-tmux-navigator") -- split window navigation

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- undotree
  use("mbbill/undotree")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- fuzzy finder
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x"})

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- snippets
  use("SirVer/ultisnips") 
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({ "glepnir/lspsaga.nvim", branch = "main" })
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- auto closing
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")

	if packer_bootstrap then
    require("packer").sync()
  end
end)
