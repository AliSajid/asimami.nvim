return {
  -- fidget.nvim configured in lspconfig.lua
  -- trouble.nvim configured in trouble.lua
  { [1] = 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  -- schemastore.nvim configured in lspconfig.lua
  'dmmulroy/ts-error-translator.nvim',
  {
    [1] = 'utilyre/barbecue.nvim',
    event = 'LspAttach',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  {
    [1] = 'Fildo7525/pretty_hover',
    event = 'LspAttach',
    keys = { '<leader>k' },
    config = true,
  },
  {
    [1] = 'karb94/neoscroll.nvim',
    keys = { '<C-d>', '<C-u>' },
    opts = {
      mappings = {
        '<C-u>',
        '<C-d>',
      },
    },
  },
  {
    [1] = 'rainbowhxch/beacon.nvim',
    event = 'CursorMoved',
    cond = function()
      -- Don't load in neovide
      return not vim.g.neovide
    end,
  },
  {
    [1] = 'wakatime/vim-wakatime',
    lazy = false,
  },
  {
    [1] = 'jannis-baum/vivify.vim',
    event = 'BufRead *.md',
    config = function()
      vim.g.vivify_instand_refresh = 1
      vim.g.vivify_filetypes = { 'markdown', 'vimwiki' }
    end,
  },
  {
    [1] = 'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'toml' },
        group = vim.api.nvim_create_augroup('EmbedToml', {}),
        callback = function()
          require('otter').activate()
        end,
      })
    end,
  },
  { [1] = 'm-demare/hlargs.nvim' },
  {
    [1] = 'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
  },
  {
    [1] = 'lukas-reineke/virt-column.nvim',
    opts = {
      virtcolumn = '+1,80,120',
    },
  },
  {
    [1] = 'tpope/vim-repeat',
  },
  {
    [1] = 'jidn/vim-dbml',
  },
}
