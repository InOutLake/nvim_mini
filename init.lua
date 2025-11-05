vim.g.maplocalleadr = '<Space>'

vim.pack.add{
  -- lsp
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  -- mini
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  -- colorscheme
  { src = 'https://github.com/folke/tokyonight.nvim'},
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  -- whichkey
  { src = 'https://github.com/folke/which-key.nvim' },
}

require('mason').setup({})
require('mason-lspconfig').setup()
require('lspconfig').ruff.setup({
  init_options = {
    settings = {
      args = {},
    }
  }
})
require('mason-tool-installer').setup({
  ensure_installed = {
    'lua_ls',
    'stylua',
    'pyright',
    'mypy',
    'ruff',
  }
})
require('which-key').setup({
  triggers = {
     { "<auto>", mode = "nixsotc" },
     { "a", mode = { "n", "v" } },
     { "<leader>", mode = { "n", "v" } },
   }
})

-- mini
-- editing
require('mini.ai').setup({})
require('mini.basics').setup({})
require('mini.surround').setup({})
require('mini.align').setup({})
require('mini.comment').setup({})
require('mini.move').setup({})
require('mini.operators').setup({})
require('mini.jump').setup({})
require('mini.indentscope').setup({})
require('mini.cursorword').setup({})
-- git and files
require('mini.git').setup({})
require('mini.files').setup({})
require('mini.bufremove').setup({})
-- lsp
require('mini.completion').setup({})
require('mini.snippets').setup({})
-- ui
require('mini.statusline').setup({})
require('mini.tabline').setup({})
require('mini.starter').setup({})
require('mini.animate').setup({})
-- NOTE: some
require('mini.hipatterns').setup({
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
    }
})
require('mini.icons').setup({})
-- utility
require('mini.misc').setup({})
require('mini.fuzzy').setup({})
require('mini.sessions').setup({})
require('mini.pick').setup({})
require('mini.notify').setup({})
-- colors
-- theme
vim.cmd[[colorscheme tokyonight]]
-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'python' },

  -- Enable syntax highlighting
  highlight = {
    enable = true,
    -- disable = { 'python' }, -- uncomment to disable for python
  },

  -- Enable text objects (e.g. `vaf` = select a function)
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },
})

-- UI behavior
-- Sidebar
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.diagnostic.config({
  float = {
    focusable = false,
    format = function(diag)
      return string.format("%s", diag.message)
    end,
  },
})
-- Highlight yanked text for a short time
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Behaviour
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<C-s>', ':w<CR>')

local MiniFiles = require('mini.files')
vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Explorer' })

local MiniPick = require('mini.pick')
vim.keymap.set('n', '<leader><leader>', function() MiniPick.builtin.files({}) end,  { desc = 'Pick file' })
vim.keymap.set('n', '<leader>g', function() MiniPick.builtin.grep_live({}) end, { desc = "Grep" })
vim.keymap.set('n', '<leader>bb', function() MiniPick.builtin.buffers() end, {desc = 'Pick buffer' })
vim.keymap.set('n', '<leader>cm', ':Mason<CR>', { desc = 'Mason' })

