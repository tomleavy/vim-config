call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'overcache/NeoSolarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'voldikss/vim-floaterm'
Plug 'mrcjkb/rustaceanvim', { 'tag': 'v5.25.1' }
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
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'mhinz/vim-crates'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'ggandor/leap.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'smjonas/inc-rename.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'MunifTanjim/nui.nvim'
Plug 'amitds1997/remote-nvim.nvim'
Plug 'huggingface/llm.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ray-x/starry.nvim'
Plug 'Saghen/blink.cmp', { 'tag': 'v0.13.1' }
Plug 'Saghen/blink.compat', { 'tag': 'v2.4.0' }

" Avante Deps
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make', 'source': 'true' }

" Code Companion
Plug 'olimorris/codecompanion.nvim', { 'tag': 'v15.9.0' }

call plug#end()
