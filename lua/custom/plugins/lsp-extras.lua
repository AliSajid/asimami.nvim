return {
  'dmmulroy/ts-error-translator.nvim',
  {
    'utilyre/barbecue.nvim',
    event = 'LspAttach',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    keys = { '<leader>k' },
    config = true,
  },
  {
    'jmbuhr/otter.nvim',
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
}
