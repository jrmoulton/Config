
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Vim Enhancements
	use '9mm/vim-closer'
	use 'airblade/vim-rooter'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-commentary'
	use 'wakatime/vim-wakatime'

	-- Gui enhancements
	use 'preservim/nerdtree'
	use 'andymass/vim-matchup'
	use 'p00f/nvim-ts-rainbow'
	use 'airblade/vim-gitgutter'
	use 'f-person/git-blame.nvim'
	use { 'j-hui/fidget.nvim', config=function() require'fidget'.setup({}) end, }
	use { '~/Programming/onedark.nvim', config=function() require'onedark'.setup({
		functionStyle = "italic",
		commentStyle = "NONE",
		transparent = true,

	}) end, }
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config=function() require'lualine'.setup({
			options = {
				theme = 'onedark'
			}
		}) end,
	}
	use {
		'norcalli/nvim-colorizer.lua', config=function() require'colorizer'.setup() end,
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use 'gelguy/wilder.nvim'
	use {
		'AckslD/nvim-neoclip.lua',
		config = function()
			require('neoclip').setup()
		end,
	}
    -- use "lukas-reineke/indent-blankline.nvim"

	-- Semantic language support
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use 'L3MON4D3/LuaSnip'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {
		'ray-x/lsp_signature.nvim'
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} },
	}

	use {'nvim-telescope/telescope-fzy-native.nvim' }
	use {'pwntester/octo.nvim', config=function()
		require"octo".setup()
	end}

	-- Syntactic language support
	use 'cespare/vim-toml'
	use 'stephpy/vim-yaml'
	use 'mfussenegger/nvim-jdtls'
	use 'rhysd/vim-clang-format'
	use 'godlygeek/tabular'
	use 'plasticboy/vim-markdown'
	use 'jakewvincent/texmagic.nvim'
	use 'simrat39/rust-tools.nvim'
	use 'rust-lang/rust.vim'
	use 'vim-python/python-syntax'
	use 'RustemB/sixtyfps-vim'

	-- Debugger
	use 'mfussenegger/nvim-dap'
	use { 'theHamsta/nvim-dap-virtual-text', config=function() require("nvim-dap-virtual-text").setup() end, }
	use { 'nvim-telescope/telescope-dap.nvim', config=function() require('telescope').load_extension('dap') end, }
    use 'mfussenegger/nvim-dap-python'
    use 'jbyuki/one-small-step-for-vimkind'
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
