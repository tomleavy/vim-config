local data_dir = vim.fn.stdpath('data') .. '/site'

if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) > 0 then
  vim.fn.system({'curl', '-fLo', data_dir .. '/autoload/plug.vim', '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
  vim.cmd [[autocmd VimEnter * PlugInstall --sync]]
end

vim.opt.mouse = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"typescript", "javascript", "json", "lua", "javascriptreact", "typescriptreact"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 0
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.smarttab = true
  end
})

vim.opt.number = true
vim.opt.termguicolors = true

-- Plugins
vim.cmd [[source ~/.config/nvim/plug.vim]]

vim.cmd [[colorscheme tokyonight-night]]

vim.cmd [[syntax on]]
vim.opt.cursorline = true

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.shortmess:append("c")
vim.opt.spell = true

vim.g.floaterm_height = 0.95
vim.g.floaterm_width = 0.75


require("bufferline").setup{}
require('gitsigns').setup()
require"fidget".setup{}
require('trouble').setup()

require('render-markdown').setup {
  file_types = { "markdown", "codecompanion" }
}

vim.treesitter.language.register('markdown', 'codecompanion')

vim.keymap.set('n', '<C-]>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-[>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<esc>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gt', ':Trouble diagnostics toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gc', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true })

local nvim_lsp = require('lspconfig')

-- Completion
require('nvim-autopairs').setup{}

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Alias a command to refresh bedrock keys 
local refresh_bedrock_keys = function(opts)
    local key = vim.system({'/opt/bin/bedrock_key_refresh'}, {text = true}):wait().stdout
    vim.env.BEDROCK_KEYS = string.sub(key,1,-2)

    
end

require("codecompanion").setup({
  adapters = {
    opts = {
      show_defaults = false,
    },
    bedrock = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "bedrock",
        url = "http://Fargat-Proxy-X4Z503HThxuQ-2142124040.us-east-1.elb.amazonaws.com/api/v1/chat/completions",
        opts = {
          show_defaults = false,
          stream = true,
        },
        env = {
          api_key = function()
            return vim.env.OPENAI_API_KEY
          end
        },
        parameters = {
          stream = true,
          stream_options = { include_usage = true },
        },
        schema = {
          model = {
            order = 1,
            mapping = "parameters",
            type = "enum",
            desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
            default = "us.anthropic.claude-3-7-sonnet-20250219-v1:0",  -- define llm model to be used
            choices = {
              ["us.anthropic.claude-3-7-sonnet-20250219-v1:0"] = { opts = { can_reason = true, stream = true } }
            },
          },
          reasoning_effort = {
            order = 2,
            mapping = "parameters",
            type = "string",
            optional = false,
            default = "medium",
            desc = "Constrains effort on reasoning for reasoning models. Reducing reasoning effort can result in faster responses and fewer tokens used on reasoning in a response.",
            choices = {
              "high",
              "medium",
              "low",
            },
          },
          max_tokens = {
            order = 6,
            mapping = "parameters",
            type = "integer",
            optional = false,
            default = 100000,
            desc = "The maximum number of tokens to generate in the chat completion. The total length of input tokens and generated tokens is limited by the model's context length.",
            validate = function(n)
              return n > 0, "Must be greater than 0"
            end,
          },
        },
      })
    end,
  },
  display = {
    chat = {
      show_settings = true,
      window = {
        position = "right",
        width = 0.40,
        relative = "editor"
      }
    },
    diff = {
      enabled = false,
    }
  },
  strategies = {
    chat = { adapter = "bedrock" },
    inline = { adapter = "bedrock" },
    agent = { adapter = "bedrock" },
  },
})

vim.api.nvim_create_user_command('AvanteKeyRefresh', refresh_bedrock_keys, {})

require('blink.compat').setup()

require('blink.cmp').setup {
    keymap = {
        preset = 'enter'
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,  
        },
        accept = { auto_brackets = { enabled = false }, },
        ghost_text = { enabled = true },
    },
    cmdline = {
        sources = {}
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "avante_commands",
            "avante_mentions",
            "avante_files",
        },
        providers = {
            avante_commands = {
              name = "avante_commands",
              module = "blink.compat.source",
              score_offset = 90, -- show at a higher priority than lsp
              opts = {},
            },
            avante_files = {
              name = "avante_files",
              module = "blink.compat.source",
              score_offset = 100, -- show at a higher priority than lsp
              opts = {},
            },
            avante_mentions = {
              name = "avante_mentions",
              module = "blink.compat.source",
              score_offset = 1000, -- show at a higher priority than lsp
              opts = {},
            }
        },
    },
    signature = { enabled = false }
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Typescript
nvim_lsp.ts_ls.setup {
    capabilities = capabilities,
}

local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not base_on_attach then return end

    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
})

vim.lsp.enable('eslint')

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
            -- target = "i686-linux-android",
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

local format_sync_grp = vim.api.nvim_create_augroup("Format", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
      vim.lsp.buf.format({ timeout_ms = 500 })
  end,
  group = format_sync_grp,
})

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

-- Spell suggestion
vim.keymap.set('n', 'gs', 'z=', { noremap = true, silent = true })

-- Hover Doc
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })

-- LSP Find Usage
vim.keymap.set('n', 'gh', function()
    require('telescope.builtin').lsp_definitions({jump_type = "never"})
end, { noremap = true, silent = true })
vim.keymap.set('n', 'gu', function()
    require('telescope.builtin').lsp_references({jump_type = "never"})
end, { noremap = true, silent = true })

-- Rust run tests
vim.keymap.set('n', 'gb', function()
    vim.cmd.RustLsp('runnables')
end, { noremap = true, silent = true })

-- LSP Code Action
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { noremap = true, silent = true })

-- Vertical Split
vim.keymap.set('n', '<C-t>', ':vsp<CR>', { noremap = true, silent = true })

-- Line diagnostics
vim.keymap.set('n', 'gd', vim.diagnostic.open_float, { noremap = true, silent = true })

-- Telescope Bindings
vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'fd', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { noremap = true, silent = true })

-- Toggle inlay hints
vim.keymap.set('n', '<C-i>', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { noremap = true, silent = true })

-- Set signcolumn
vim.opt.signcolumn = "yes"

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

-- Floating Terminal
vim.keymap.set('n', 'tt', ':FloatermToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

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

-- Swift
require'lspconfig'.sourcekit.setup{
    capabilities = capabilities
}

require'lspconfig'.pyright.setup {
    capabilities = capabilities
}

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"swift"},
  callback = function()
    vim.api.nvim_create_autocmd({"BufWritePost"}, {
      pattern = {"*.swift"},
      command = "silent !swiftformat %"
    })
  end
})

-- Toggle crates for Cargo.toml
if vim.fn.has('nvim') == 1 then
  vim.api.nvim_create_autocmd({"BufRead"}, {
    pattern = {"Cargo.toml"},
    callback = function()
      vim.fn['crates#toggle']()
    end
  })
end
