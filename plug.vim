call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim', { 'branch': 'main' }
Plug 'nvim-lua/popup.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'overcache/NeoSolarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'voldikss/vim-floaterm'
Plug 'mfussenegger/nvim-dap'
Plug 'simrat39/rust-tools.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'mattn/efm-langserver'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mhinz/vim-crates'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'
Plug 'lewis6991/spellsitter.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'ggandor/leap.nvim'
call plug#end()
