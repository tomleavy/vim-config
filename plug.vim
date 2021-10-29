call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'rinx/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'overcache/NeoSolarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'voldikss/vim-floaterm'
Plug 'mfussenegger/nvim-dap'
Plug 'alx741/vim-rustfmt'
Plug 'windwp/nvim-autopairs'
Plug 'simrat39/rust-tools.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'mattn/efm-langserver'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mhinz/vim-crates'
call plug#end()
