return {
  specs = {
    { src = 'https://github.com/kevinhwang91/nvim-ufo' },
    { src = 'https://github.com/kevinhwang91/promise-async' },
  },
  config = function()
    require('ufo').setup {
      open_fold_hl_timeout = 400,
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
    }
  end,
}
