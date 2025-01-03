let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd Filetype typescript setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype javascript setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype json setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

set number
set termguicolors



" Plugins
source ~/.config/nvim/plug.vim


colorscheme tokyonight-night

syntax on
set t_Co=256
set cursorline

set completeopt=menu,menuone,noselect
set shortmess+=c
set spell

let g:floaterm_height = 0.95
let g:floaterm_width = 0.75

lua << EOF
require("bufferline").setup{}

EOF

nnoremap <silent> <C-]> :BufferLineCycleNext<CR>
nnoremap <silent> <C-[> :BufferLineCyclePrev<CR>
nnoremap <silent> <esc> :BufferLineCyclePrev<CR>
nnoremap gt <cmd>Trouble diagnostics toggle<cr>

lua << EOF
require('gitsigns').setup()
require"fidget".setup{}

require('trouble').setup()

local nvim_lsp = require('lspconfig')

-- Completion
require('nvim-autopairs').setup{}

require('blink.cmp').setup {
    keymap = {
        preset = 'enter'
    }
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Typescript
nvim_lsp.ts_ls.setup {
    capabilities = capabilities,
}

nvim_lsp.eslint.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.lsp.buf.format()
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end,
}

-- Mappings.
local opts = { noremap=true, silent=true }

-- RUST
local on_attach = function(client, bufnr)
    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
                return
            end
            return default_diagnostic_handler(err, result, context, config)
        end
    end
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    autoSetHints = true,
    inlay_hints = {
        show_parameter_hints = true,
        only_current_line = false,
        parameter_hints_prefix = "< ",
        other_hints_prefix = "\194\187 ",
    },
  },
  -- LSP configuration
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        files = {
            excludeDirs = {
                ".git",
                "build",
                "target",
            }
        },
        cargo = {
            -- target = "i686-linux-android"
            features = "all",
        },
        check = {
            allTargets = true,
            features = "all",
            command = "clippy",
            extraArgs = { "--no-deps" }
        },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

-- Command:
require'lspconfig'.ccls.setup{}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "html",
    "scss",
    "rust",
    "markdown"
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }

EOF

nnoremap <silent>gs z=

" Hover Doc
"nnoremap <silent>K :Lspsaga hover_doc<CR>
noremap <silent>K :lua vim.lsp.buf.hover()<CR>

" LSP Find Usage
" nnoremap <silent>gh <Cmd>Lspsaga lsp_finder<CR>
nnoremap <silent>gh :lua require('telescope.builtin').lsp_definitions({jump_type = "never"})<CR> 	
noremap <silent> gu :lua require('telescope.builtin').lsp_references({jump_type = "never"})<CR>

" Rust run tests
nnoremap <silent>gb :lua vim.cmd.RustLsp('runnables')<CR>

" LSP Code Action
"nnoremap <silent>ga :Lspsaga code_action<CR>
nnoremap <silent>ga :lua vim.lsp.buf.code_action()<CR>

" Vertical Split
nnoremap <silent> <C-t> :vsp<CR>

" Line diagnostics
nnoremap <silent>gd :lua vim.diagnostic.open_float()<CR>

" Telescope Bindings
nnoremap <silent> ff <cmd>Telescope find_files<cr>
nnoremap <silent> fg <cmd>Telescope live_grep<cr>
nnoremap <silent> fd <cmd>Telescope current_buffer_fuzzy_find<cr>

set signcolumn=yes

lua << EOF
require('telescope').setup{ 
    extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
    },
    defaults = { 
        file_ignore_patterns = {"node_modules", "build/.*", "target/.*", "docs/.*"},
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        }
    },
}

require("dressing").setup{}

require("inc_rename").setup {
    input_buffer_type = "dressing",
}

require('telescope').load_extension("ui-select")

vim.keymap.set("n", "gr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

EOF

"Floating Terminal
nnoremap <silent> tt :FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>:FloatermToggle<CR>

" Close Telescope Windows
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

lua << EOF
local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
      vim.lsp.buf.format({ timeout_ms = 500 })
  end,
  group = format_sync_grp,
})

-- Swift
require'lspconfig'.sourcekit.setup{
    capabilities = capabilities
}

require'lspconfig'.pyright.setup {
    capabilities = capabilities
}

EOF

autocmd FileType swift autocmd BufWritePost *.swift :silent exec "!swiftformat %"

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif
