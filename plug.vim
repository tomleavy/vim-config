call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'mrcjkb/rustaceanvim', { 'tag': 'v6.7.0' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-repeat'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'smjonas/inc-rename.nvim'
Plug 'Saghen/blink.cmp', { 'tag': 'v1.6.0' }
Plug 'Saghen/blink.pairs', { 'tag': 'v0.3.0' }
Plug 'Saghen/blink.download',
Plug 'olimorris/codecompanion.nvim', { 'tag': 'v17.15.0' }
Plug 'MeanderingProgrammer/render-markdown.nvim', { 'tag': 'v8.7.0' }
Plug 'mhinz/vim-crates'
call plug#end()
